#!/usr/bin/env node
// Remote transport entry point: the same four tools over streamable HTTP.
//
//   npx elgarde-mcp-http
//   PORT=9000 HOST=:: npx elgarde-mcp-http

import { httpServer } from '../http.js';

const port = Number(process.env.PORT ?? 8200);
const host = process.env.HOST ?? '127.0.0.1';

httpServer.listen(port, host, () => {
  console.error(`elgarde-mcp listening on http://${host}:${port}/mcp`);
});
