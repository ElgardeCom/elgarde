/**
 * The Elgarde MCP server — what to check when buying a used car.
 *
 * Four tools over the open Elgarde inspection canon:
 *
 *   get_inspection_checklist   the adaptive checklist for a given car
 *   get_known_defects          curated model-specific weak points
 *   score_inspection           roll 1-5 answers into one verdict
 *   decode_vin                 VIN -> make/model/year (free NHTSA vPIC data)
 *
 * The first three are local and offline: the data ships inside the
 * `elgarde-inspection` package. Only decode_vin reaches the network, and it
 * calls the free public Elgarde API with no key and no user data attached.
 */

import {
  allItems,
  assemble,
  canonVersion,
  localize,
  matchDefectRule,
  overall,
  overallBeforeClamp,
  pick,
  progress,
} from 'elgarde-inspection';
import { McpServer } from '@modelcontextprotocol/sdk/server/mcp.js';
import { z } from 'zod';

export const API_BASE = process.env.ELGARDE_API_BASE ?? 'https://api.elgarde.com/api';

export const DISCLAIMER =
  'Elgarde is a self-service checklist, not a certified, mechanical or legal ' +
  'inspection and not professional advice. Defect entries are known weak points ' +
  'to check on a model — never a claim about any individual car. ' +
  'Data: https://elgarde.com/ (CC-BY-4.0).';

const LANGS = ['en', 'pt', 'ru', 'uk', 'fr'];
const FUELS = ['petrol', 'diesel', 'hybrid', 'ev', 'other'];

const text = (body) => ({ content: [{ type: 'text', text: body }] });
const failure = (body) => ({ content: [{ type: 'text', text: body }], isError: true });

const carLabel = ({ make, model, fuelType }) =>
  [make, model, fuelType].filter(Boolean).join(' ') || 'an unspecified car';

// ---------------------------------------------------------------------------
// Rendering — assistants read these strings, so they are written to be read.
// ---------------------------------------------------------------------------

function renderChecklist(car, lang) {
  const groups = assemble(car);
  const total = allItems(groups).length;
  const lines = [
    `Pre-purchase inspection checklist for ${carLabel(car)} — ${total} items.`,
    'Score each item 1-5 (1 = worst). Items marked [critical] cap the overall verdict.',
    '',
  ];

  for (const group of localize(groups, lang)) {
    lines.push(`## ${group.title}`);
    const render = (node, indent) => {
      for (const item of node.items ?? []) {
        lines.push(
          `${indent}- ${item.prompt}${item.critical ? '  [critical]' : ''}`,
        );
      }
      for (const child of node.children ?? []) {
        lines.push(`${indent}### ${child.title}`);
        render(child, `${indent}  `);
      }
    };
    render(group, '');
    lines.push('');
  }

  lines.push(DISCLAIMER);
  return lines.join('\n');
}

function renderDefects(make, model, lang) {
  const rule = matchDefectRule(make, model);
  if (rule === null) {
    return [
      `No model-specific defects are curated for ${[make, model].filter(Boolean).join(' ')}.`,
      '',
      'This is not a statement that the model has no known issues — only that ' +
        'Elgarde has not curated any for it yet. Run the general inspection ' +
        'checklist (get_inspection_checklist) instead.',
      '',
      DISCLAIMER,
    ].join('\n');
  }

  const lines = [
    `${pick(rule.label, lang)} — ${rule.defects.length} known weak points to check ` +
      `on ${[make, model].filter(Boolean).join(' ')}:`,
    '',
  ];
  for (const defect of rule.defects) {
    lines.push(`- ${pick(defect.text, lang)}${defect.critical ? '  [critical]' : ''}`);
  }
  lines.push('', DISCLAIMER);
  return lines.join('\n');
}

function renderScore(car, scores) {
  const groups = assemble(car);
  const [answered, total] = progress(groups, scores);
  const before = overallBeforeClamp(groups, scores);
  const verdict = overall(groups, scores);

  if (verdict === null) {
    return `Nothing scored yet — 0 of ${total} items answered.`;
  }

  const round = (value) => Math.round(value * 100) / 100;
  const lines = [
    `Overall verdict: ${round(verdict)} / 5  (${answered} of ${total} items answered)`,
  ];

  if (before !== null && Math.abs(before - verdict) > 1e-9) {
    const clamped = allItems(groups)
      .filter(
        (item) =>
          item.critical &&
          typeof scores[item.id] === 'number' &&
          scores[item.id] > 0 &&
          scores[item.id] <= 2,
      )
      .map((item) => item.id);
    lines.push(
      `The unclamped average was ${round(before)}, lowered by a failing critical ` +
        `item: ${clamped.join(', ')}.`,
    );
  }

  lines.push('', 'By section:');
  for (const group of localize(groups, 'en')) {
    const source = groups.find((g) => g.id === group.id);
    const score = overallBeforeClamp([source], scores);
    lines.push(`- ${group.title}: ${score === null ? 'not scored' : round(score)}`);
  }
  lines.push('', DISCLAIMER);
  return lines.join('\n');
}

async function decodeVin(vin) {
  const normalized = vin.trim().toUpperCase();
  if (!/^[A-HJ-NPR-Z0-9]{17}$/.test(normalized)) {
    return failure(
      'A VIN is 17 characters, letters and digits, excluding I, O and Q. ' +
        `Got ${JSON.stringify(vin)}.`,
    );
  }

  let response;
  try {
    response = await fetch(`${API_BASE}/v1/vin/${normalized}`, {
      headers: { accept: 'application/json', 'user-agent': 'elgarde-mcp' },
    });
  } catch (error) {
    return failure(`Could not reach the Elgarde API: ${error.message}`);
  }
  if (!response.ok) {
    return failure(
      `The Elgarde API returned ${response.status} for that VIN. ` +
        (response.status === 429
          ? 'The free tier is rate-limited — try again in a minute.'
          : ''),
    );
  }

  const body = await response.json();
  const car = body.car ?? {};
  const known = Object.entries(car)
    .filter(([, value]) => value !== null && value !== undefined)
    .map(([key, value]) => `${key}: ${value}`);

  return text(
    [
      `VIN ${normalized} decoded from the free NHTSA vPIC dataset:`,
      ...known.map((line) => `- ${line}`),
      '',
      'vPIC is US-centric and thin on European models, so missing fields are ' +
        'normal rather than an error. Pass the make, model and fuel type on to ' +
        'get_inspection_checklist for a checklist adapted to this car.',
      '',
      DISCLAIMER,
    ].join('\n'),
  );
}

// ---------------------------------------------------------------------------
// Server
// ---------------------------------------------------------------------------

export function createServer() {
  const server = new McpServer(
    { name: 'elgarde-inspection', version: '1.0.0' },
    {
      instructions:
        'Elgarde answers "what should I check before buying this used car?". ' +
        'Start with get_inspection_checklist for a car-specific checklist, or ' +
        'get_known_defects for that model\'s documented weak points. Feed 1-5 ' +
        'answers back through score_inspection for a verdict. It is a ' +
        'structured self-service checklist, not a certified inspection — say so ' +
        'when you present its output.',
    },
  );

  server.registerTool(
    'get_inspection_checklist',
    {
      title: 'Get a pre-purchase car inspection checklist',
      description:
        'The inspection checklist for a specific used car, adapted to it: base ' +
        'items for every car, fuel-specific items (DPF and glow plugs for a ' +
        'diesel, battery health and charging for an EV), and the known weak ' +
        'points of the model when one is curated. Available in English, ' +
        'Portuguese, Russian, Ukrainian and French. Works offline.',
      inputSchema: {
        make: z.string().optional().describe('e.g. "Volkswagen"'),
        model: z.string().optional().describe('e.g. "Golf"'),
        fuelType: z.enum(FUELS).optional(),
        lang: z.enum(LANGS).optional().describe('Defaults to English.'),
      },
      annotations: { readOnlyHint: true, openWorldHint: false },
    },
    async ({ make, model, fuelType, lang }) =>
      text(renderChecklist({ make, model, fuelType }, lang ?? 'en')),
  );

  server.registerTool(
    'get_known_defects',
    {
      title: "Get a model's known weak points",
      description:
        'Curated, model-specific things that commonly go wrong — the DQ200 dry ' +
        'clutch, the PureTech wet timing belt, the N47 timing chain. Returns ' +
        'nothing when no defects are curated for that model, which is not the ' +
        'same as the model having none. Works offline.',
      inputSchema: {
        make: z.string().describe('e.g. "Peugeot"'),
        model: z.string().describe('e.g. "208"'),
        lang: z.enum(['en', 'pt']).optional().describe('Defaults to English.'),
      },
      annotations: { readOnlyHint: true, openWorldHint: false },
    },
    async ({ make, model, lang }) => text(renderDefects(make, model, lang ?? 'en')),
  );

  server.registerTool(
    'score_inspection',
    {
      title: 'Score a completed inspection',
      description:
        'Turns answered checklist items into per-section scores and one overall ' +
        '1-5 verdict. Answers are 1-5 (1 = worst), or -1 for not applicable and ' +
        '-2 for not inspected. A critical item scoring 2 or below clamps the ' +
        'verdict down to it, so a car can average 4.9 and still come out a 1. ' +
        'Item ids come from get_inspection_checklist. Works offline.',
      inputSchema: {
        scores: z
          .record(z.string(), z.number().int().min(-2).max(5))
          .describe('Checklist item id -> score, e.g. {"ext.body.rust": 3}'),
        make: z.string().optional(),
        model: z.string().optional(),
        fuelType: z.enum(FUELS).optional(),
      },
      annotations: { readOnlyHint: true, openWorldHint: false },
    },
    async ({ scores, make, model, fuelType }) =>
      text(renderScore({ make, model, fuelType }, scores)),
  );

  server.registerTool(
    'decode_vin',
    {
      title: 'Decode a VIN',
      description:
        'Decodes a 17-character VIN into make, model, year, fuel type and body ' +
        'style using the free NHTSA vPIC dataset, through the public Elgarde ' +
        'API. US-centric and thin on European models, so partial results are ' +
        'normal. This is the only tool that uses the network.',
      inputSchema: {
        vin: z.string().describe('17 characters, no I, O or Q.'),
      },
      annotations: { readOnlyHint: true, openWorldHint: true },
    },
    async ({ vin }) => decodeVin(vin),
  );

  server.registerResource?.(
    'canon-version',
    'elgarde://canon/version',
    {
      title: 'Inspection canon version',
      description: 'Which version of the Elgarde inspection data this server serves.',
      mimeType: 'application/json',
    },
    async (uri) => ({
      contents: [
        {
          uri: uri.href,
          mimeType: 'application/json',
          text: JSON.stringify(
            { ...canonVersion(), source: 'https://github.com/ElgardeCom/elgarde' },
            null,
            2,
          ),
        },
      ],
    }),
  );

  return server;
}
