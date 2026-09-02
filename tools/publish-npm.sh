#!/usr/bin/env bash
# Publish both npm packages, in the order that has to hold, and prove they work.
#
#   bash tools/publish-npm.sh                 # uses whatever auth ~/.npmrc has
#   bash tools/publish-npm.sh --otp 123456    # one-time code instead of a token
#
# Idempotent: a package already on the registry is skipped, so re-running after
# a failure only does what is left.
#
# The token never appears here. Set it once, from a directory outside this
# monorepo (npm config refuses to run inside a workspace):
#
#   cd ~ && npm config set //registry.npmjs.org/:_authToken=THE_TOKEN
#
# elgarde-inspection must exist on the registry before elgarde-mcp: the MCP
# server depends on it, so publishing mcp first ships something installable but
# broken.

set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
OTP_ARGS=()
if [[ "${1:-}" == "--otp" && -n "${2:-}" ]]; then
  OTP_ARGS=(--otp "$2")
fi

published() { curl -fsS -o /dev/null "https://registry.npmjs.org/$1" 2>/dev/null; }

latest() {
  curl -fsS "https://registry.npmjs.org/$1" 2>/dev/null \
    | python3 -c 'import json,sys; print(json.load(sys.stdin)["dist-tags"]["latest"])'
}

publish() {
  local name="$1" dir="$2"
  if published "$name"; then
    echo "==> $name already on the registry at $(latest "$name") — skipping"
    return 0
  fi

  echo "==> publishing $name from $dir"
  ( cd "$ROOT/$dir" && npm publish "${OTP_ARGS[@]}" )

  echo -n "    waiting for the registry to serve it "
  for _ in $(seq 1 30); do
    if published "$name"; then echo " ok ($(latest "$name"))"; return 0; fi
    echo -n .
    sleep 2
  done
  echo
  echo "    published, but the registry has not served it yet — re-run to continue"
  return 1
}

echo "npm user: $(npm whoami 2>/dev/null || echo 'NOT LOGGED IN')"
echo

publish elgarde-inspection packages/js
publish elgarde-mcp mcp

echo
echo "==> installing elgarde-mcp from the registry into a scratch directory"
scratch="$(mktemp -d)"
trap 'rm -rf "$scratch"' EXIT
( cd "$scratch" && npm install --silent --no-audit --no-fund elgarde-mcp >/dev/null )

echo "==> a real MCP handshake against the installed copy"
request='{"jsonrpc":"2.0","id":1,"method":"initialize","params":{"protocolVersion":"2025-06-18","capabilities":{},"clientInfo":{"name":"smoke","version":"1"}}}'
reply="$(printf '%s\n' "$request" \
  | node "$scratch/node_modules/elgarde-mcp/bin/elgarde-mcp.js" | head -1)"

if grep -q '"serverInfo"' <<<"$reply"; then
  echo "    OK — the published package starts and answers initialize"
else
  echo "    FAILED — no serverInfo in the reply:"
  echo "    $reply"
  exit 1
fi

echo
echo "Done."
echo "  https://www.npmjs.com/package/elgarde-inspection"
echo "  https://www.npmjs.com/package/elgarde-mcp"
echo
echo "Now revoke the token you pasted into the chat, at"
echo "  https://www.npmjs.com/settings/~/tokens"
