#!/bin/bash

set -euo pipefail

KO_DOCKER_REPO=$(cat /root/images/repo)
export KO_DOCKER_REPO
REGISTRY_PASSWORD=$(cat /root/images/access-token)
REGISTRY=$(cat /root/images/registry)
ID_TOKEN=$(cat /root/images/sign.id-token)

echo -n "$REGISTRY_PASSWORD"| docker login  "$REGISTRY" \
  --username oauth2accesstoken \
  --password-stdin 

IMG_REF=$(ko build  \
  --platform=linux/arm64 \
  --platform=linux/amd64 /drone/src/cmd/server)

cosign sign --identity-token="$ID_TOKEN" "$IMG_REF"
