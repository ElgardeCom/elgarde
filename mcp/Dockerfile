# The remote (streamable HTTP) transport, containerised.
#
#   docker build -t elgarde-mcp .
#   docker run --rm -p 127.0.0.1:8200:8200 elgarde-mcp
#   curl localhost:8200/health
#
# Standalone: the inspection canon arrives through the published
# `elgarde-inspection` package, so this needs nothing from the rest of the
# repository. Put a TLS-terminating reverse proxy in front — see the nginx
# vhost in the deployment notes.

FROM node:22-alpine

WORKDIR /app

# Dependencies first, so a code change does not re-resolve the tree.
COPY package.json ./
RUN npm install --omit=dev --no-audit --no-fund && npm cache clean --force

COPY server.js http.js ./
COPY bin ./bin

ENV NODE_ENV=production \
    PORT=8200 \
    HOST=0.0.0.0

EXPOSE 8200
USER node

# The server holds no state and touches no disk; the only outbound call is the
# public Elgarde API, used by decode_vin.
HEALTHCHECK --interval=30s --timeout=5s --start-period=5s --retries=3 \
  CMD node -e "fetch('http://127.0.0.1:8200/health').then(r=>process.exit(r.ok?0:1)).catch(()=>process.exit(1))"

CMD ["node", "http.js"]
