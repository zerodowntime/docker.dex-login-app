#!/bin/sh

exec /usr/local/bin/login-app \
  --client-id "$DEX_CLIENT_ID" \
  --client-secret "$DEX_CLIENT_SECRET" \
  --issuer "$DEX_ISSUER" \
  --listen "$DEX_LISTEN" \
  --redirect-uri "$DEX_REDIRECT_URI"
