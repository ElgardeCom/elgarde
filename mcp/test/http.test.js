// The remote transport, driven over a real socket by a real MCP client.

import assert from 'node:assert/strict';
import test from 'node:test';

import { Client } from '@modelcontextprotocol/sdk/client/index.js';
import { StreamableHTTPClientTransport } from '@modelcontextprotocol/sdk/client/streamableHttp.js';

import { httpServer } from '../http.js';

async function listen() {
  await new Promise((resolve) => httpServer.listen(0, '127.0.0.1', resolve));
  const { port } = httpServer.address();
  return `http://127.0.0.1:${port}`;
}

test('serves the tools over streamable HTTP', async (t) => {
  const base = await listen();
  t.after(() => new Promise((resolve) => httpServer.close(resolve)));

  const client = new Client({ name: 'test', version: '1.0.0' });
  await client.connect(new StreamableHTTPClientTransport(new URL(`${base}/mcp`)));

  const { tools } = await client.listTools();
  assert.equal(tools.length, 4);

  const result = await client.callTool({
    name: 'get_known_defects',
    arguments: { make: 'BMW', model: '320d' },
  });
  assert.match(result.content[0].text, /N47/);

  await client.close();

  const health = await fetch(`${base}/health`);
  assert.equal(health.status, 200);
  assert.deepEqual(await health.json(), { status: 'ok', server: 'elgarde-mcp' });

  const missing = await fetch(`${base}/nope`, { method: 'POST' });
  assert.equal(missing.status, 404);
});
