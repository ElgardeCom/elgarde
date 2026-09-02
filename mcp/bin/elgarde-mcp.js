#!/usr/bin/env node
// stdio entry point: what an MCP client spawns.
//
//   npx elgarde-mcp
//
// Claude Desktop / Claude Code config:
//   { "mcpServers": { "elgarde": { "command": "npx", "args": ["-y", "elgarde-mcp"] } } }

import { StdioServerTransport } from '@modelcontextprotocol/sdk/server/stdio.js';

import { createServer } from '../server.js';

const server = createServer();
await server.connect(new StdioServerTransport());
