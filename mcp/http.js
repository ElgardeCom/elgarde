/**
 * Remote transport: the same four tools over streamable HTTP, so a client can
 * point at a URL instead of spawning a process.
 *
 *   node http.js                 # listens on 127.0.0.1:8200, POST /mcp
 *   PORT=9000 HOST=:: node http.js
 *
 * Stateless by design — a fresh server and transport per request, no session
 * store, nothing to expire. The tools are read-only and hold no user state, so
 * there is nothing worth keeping between calls, and a stateless server can be
 * restarted or scaled without dropping anyone's session.
 */

import { createServer as createHttpServer } from 'node:http';

import { StreamableHTTPServerTransport } from '@modelcontextprotocol/sdk/server/streamableHttp.js';

import { createServer } from './server.js';

const PORT = Number(process.env.PORT ?? 8200);
const HOST = process.env.HOST ?? '127.0.0.1';
const MAX_BODY_BYTES = 1_000_000;

function send(res, status, body) {
  const payload = JSON.stringify(body);
  res.writeHead(status, {
    'content-type': 'application/json',
    'content-length': Buffer.byteLength(payload),
  });
  res.end(payload);
}

function rpcError(res, status, code, message) {
  send(res, status, { jsonrpc: '2.0', error: { code, message }, id: null });
}

function readBody(req) {
  return new Promise((resolve, reject) => {
    const chunks = [];
    let size = 0;
    req.on('data', (chunk) => {
      size += chunk.length;
      if (size > MAX_BODY_BYTES) {
        reject(new Error('request body too large'));
        req.destroy();
        return;
      }
      chunks.push(chunk);
    });
    req.on('end', () => resolve(Buffer.concat(chunks).toString('utf8')));
    req.on('error', reject);
  });
}

export const httpServer = createHttpServer(async (req, res) => {
  // Browsers may probe this endpoint; the tools are public and read-only.
  res.setHeader('access-control-allow-origin', '*');
  res.setHeader('access-control-allow-methods', 'POST, GET, OPTIONS');
  res.setHeader(
    'access-control-allow-headers',
    'content-type, mcp-session-id, mcp-protocol-version, accept',
  );
  res.setHeader('access-control-expose-headers', 'mcp-session-id');

  if (req.method === 'OPTIONS') {
    res.writeHead(204).end();
    return;
  }

  const path = (req.url ?? '/').split('?')[0];

  if (path === '/health') {
    send(res, 200, { status: 'ok', server: 'elgarde-mcp' });
    return;
  }

  if (path !== '/mcp') {
    rpcError(res, 404, -32601, 'Not found. The MCP endpoint is POST /mcp.');
    return;
  }

  if (req.method !== 'POST') {
    // Stateless: there is no long-lived stream to attach to with GET.
    rpcError(res, 405, -32000, 'Method not allowed. Use POST /mcp.');
    return;
  }

  let body;
  try {
    body = JSON.parse((await readBody(req)) || 'null');
  } catch (error) {
    rpcError(res, 400, -32700, `Parse error: ${error.message}`);
    return;
  }

  const server = createServer();
  const transport = new StreamableHTTPServerTransport({
    sessionIdGenerator: undefined,
  });

  res.on('close', () => {
    transport.close();
    server.close();
  });

  try {
    await server.connect(transport);
    await transport.handleRequest(req, res, body);
  } catch (error) {
    if (!res.headersSent) {
      rpcError(res, 500, -32603, `Internal error: ${error.message}`);
    }
  }
});

const isEntryPoint =
  process.argv[1] && import.meta.url === `file://${process.argv[1]}`;

if (isEntryPoint) {
  httpServer.listen(PORT, HOST, () => {
    console.error(`elgarde-mcp listening on http://${HOST}:${PORT}/mcp`);
  });
}
