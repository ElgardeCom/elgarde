// End-to-end over a real MCP session: an in-memory client talks to the server
// exactly as Claude Desktop would over stdio. No network — decode_vin's upstream
// is stubbed, so these tests never call the live API.

import assert from 'node:assert/strict';
import test from 'node:test';

import { Client } from '@modelcontextprotocol/sdk/client/index.js';
import { InMemoryTransport } from '@modelcontextprotocol/sdk/inMemory.js';

import { createServer } from '../server.js';

async function connect() {
  const [clientTransport, serverTransport] = InMemoryTransport.createLinkedPair();
  const client = new Client({ name: 'test', version: '1.0.0' });
  await Promise.all([
    createServer().connect(serverTransport),
    client.connect(clientTransport),
  ]);
  return client;
}

const textOf = (result) =>
  result.content
    .filter((part) => part.type === 'text')
    .map((part) => part.text)
    .join('\n');

test('advertises exactly the four tools, each described', async () => {
  const client = await connect();
  const { tools } = await client.listTools();

  assert.deepEqual(
    tools.map((tool) => tool.name).sort(),
    ['decode_vin', 'get_inspection_checklist', 'get_known_defects', 'score_inspection'],
  );
  for (const tool of tools) {
    assert.ok(tool.description.length > 40, `${tool.name} needs a real description`);
    assert.equal(tool.inputSchema.type, 'object');
  }
});

test('get_inspection_checklist adapts to the car', async () => {
  const client = await connect();
  const result = await client.callTool({
    name: 'get_inspection_checklist',
    arguments: { make: 'Volkswagen', model: 'Golf', fuelType: 'diesel' },
  });
  const body = textOf(result);

  assert.match(body, /33 items/);
  assert.match(body, /DPF/); //         the diesel module
  assert.match(body, /DQ200/); //       the VAG known-defect group
  assert.match(body, /\[critical\]/);
  assert.match(body, /not a certified/);
});

test('get_inspection_checklist localises', async () => {
  const client = await connect();
  const result = await client.callTool({
    name: 'get_inspection_checklist',
    arguments: { lang: 'pt' },
  });
  assert.match(textOf(result), /Carroçaria e pintura/);
});

test('get_known_defects returns curated entries', async () => {
  const client = await connect();
  const result = await client.callTool({
    name: 'get_known_defects',
    arguments: { make: 'Peugeot', model: '208' },
  });
  const body = textOf(result);

  assert.match(body, /wet timing belt/);
  assert.match(body, /\[critical\]/);
});

test('get_known_defects resolves the facts it is given', async () => {
  const client = await connect();
  const call = async (args) =>
    textOf(await client.callTool({ name: 'get_known_defects', arguments: args }));

  // Nothing but the model: the DQ200 is possible, and the gearbox settles it.
  const golf = await call({ make: 'Volkswagen', model: 'Golf' });
  assert.match(golf, /DQ200/);
  assert.match(golf, /Possible — to settle it, find out the gearbox type/);
  assert.match(golf, /\/v1\/defects\/dsg\.dq200/);

  // A manual gearbox rules it out, and the answer says so instead of hiding it.
  const manual = await call({ make: 'Volkswagen', model: 'Golf', gearbox: 'manual' });
  assert.match(manual, /Ruled out by the facts given:\n(- .*\n)*- dsg\.dq200 \(by gearbox\)/);
  assert.doesNotMatch(manual.split('Ruled out')[0], /DQ200/);

  // The gearbox code makes it apply.
  const dsg = await call({ make: 'Volkswagen', model: 'Golf', gearboxCode: '0AM' });
  assert.match(dsg, /DQ200[^\n]*\n  Applies to this car/);
});

test('get_known_defects keeps a renamed v2 entry and links its dossier', async () => {
  const client = await connect();
  const body = textOf(
    await client.callTool({
      name: 'get_known_defects',
      arguments: { make: 'Mercedes-Benz', model: 'C-Class', engineCode: 'M271', productionDate: '2008-03' },
    }),
  );
  assert.match(body, /\/v1\/defects\/m271\.timingchain/);
  assert.match(body, /om651\.injectors \(by productionDate, engineFamily\)/);
  // A v2 entry without a sourced dossier stays, marked as such.
  assert.match(body, /Older entry: no sourced dossier yet/);
});

test('get_known_defects speaks all five languages', async () => {
  const client = await connect();
  const body = textOf(
    await client.callTool({
      name: 'get_known_defects',
      arguments: { make: 'Peugeot', model: '208', lang: 'fr' },
    }),
  );
  assert.match(body, /Problèmes connus PSA/);
});

test('get_known_defects says "not curated", never "no issues"', async () => {
  const client = await connect();
  const result = await client.callTool({
    name: 'get_known_defects',
    arguments: { make: 'Lada', model: 'Niva' },
  });
  const body = textOf(result);

  assert.match(body, /No model-specific defects are curated/);
  assert.match(body, /not a statement that the model has no known issues/);
});

test('score_inspection reports the critical clamp', async () => {
  const client = await connect();
  const result = await client.callTool({
    name: 'score_inspection',
    arguments: {
      make: 'Volkswagen',
      model: 'Golf',
      fuelType: 'diesel',
      scores: { 'docs.all.mileage': 1, 'ext.body.rust': 5, 'int.ctrl.ac': 5 },
    },
  });
  const body = textOf(result);

  assert.match(body, /Overall verdict: 1 \/ 5/);
  assert.match(body, /docs\.all\.mileage/);
  assert.match(body, /3 of 33 items answered/);
});

test('score_inspection handles an empty sheet', async () => {
  const client = await connect();
  const result = await client.callTool({
    name: 'score_inspection',
    arguments: { scores: {} },
  });
  assert.match(textOf(result), /Nothing scored yet — 0 of 25/);
});

test('score_inspection rejects an out-of-range score', async () => {
  const client = await connect();
  const result = await client.callTool({
    name: 'score_inspection',
    arguments: { scores: { 'ext.body.rust': 9 } },
  });
  assert.equal(result.isError, true);
});

test('decode_vin rejects a malformed VIN without calling the network', async () => {
  const original = globalThis.fetch;
  globalThis.fetch = () => {
    throw new Error('the network must not be touched for an invalid VIN');
  };
  try {
    const client = await connect();
    const result = await client.callTool({
      name: 'decode_vin',
      arguments: { vin: 'WVWZZZ1KZAW00000I' }, // I is not a VIN character
    });
    assert.equal(result.isError, true);
    assert.match(textOf(result), /17 characters/);
  } finally {
    globalThis.fetch = original;
  }
});

test('decode_vin renders a decoded car and points at the next step', async () => {
  const original = globalThis.fetch;
  globalThis.fetch = async (url) => {
    assert.match(String(url), /\/v1\/vin\/WVWZZZ1KZAW000001$/);
    return {
      ok: true,
      status: 200,
      json: async () => ({
        car: {
          vin: 'WVWZZZ1KZAW000001',
          make: 'VOLKSWAGEN',
          model: 'Golf',
          year: 2015,
          fuelType: 'diesel',
          bodyStyle: null,
        },
      }),
    };
  };
  try {
    const client = await connect();
    const result = await client.callTool({
      name: 'decode_vin',
      arguments: { vin: 'wvwzzz1kzaw000001' },
    });
    const body = textOf(result);

    assert.match(body, /make: VOLKSWAGEN/);
    assert.match(body, /year: 2015/);
    assert.doesNotMatch(body, /bodyStyle/); //     nulls are dropped
    assert.match(body, /get_inspection_checklist/);
  } finally {
    globalThis.fetch = original;
  }
});

test('decode_vin surfaces a rate limit as a readable error', async () => {
  const original = globalThis.fetch;
  globalThis.fetch = async () => ({ ok: false, status: 429 });
  try {
    const client = await connect();
    const result = await client.callTool({
      name: 'decode_vin',
      arguments: { vin: 'WVWZZZ1KZAW000001' },
    });
    assert.equal(result.isError, true);
    assert.match(textOf(result), /rate-limited/);
  } finally {
    globalThis.fetch = original;
  }
});

test('every tool answer carries the disclaimer', async () => {
  const client = await connect();
  for (const [name, args] of [
    ['get_inspection_checklist', {}],
    ['get_known_defects', { make: 'BMW', model: '320d' }],
    ['score_inspection', { scores: { 'ext.body.rust': 4 } }],
  ]) {
    const result = await client.callTool({ name, arguments: args });
    assert.match(textOf(result), /not a certified/, name);
  }
});
