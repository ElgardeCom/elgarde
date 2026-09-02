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
