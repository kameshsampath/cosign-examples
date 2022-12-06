#!/bin/bash

set -euo pipefail

ACCESS_TOKEN=$(gcloud auth print-access-token \
  --impersonate-service-account "$(gcloud config get core/account)")
ID_TOKEN=$(gcloud auth print-identity-token \
  --audiences=sigstore  \
  --include-email \
  --impersonate-service-account "$(gcloud config get core/account)") 

export ACCESS_TOKEN
export ID_TOKEN

echo -n "$ACCESS_TOKEN" > /root/images/access-token
echo -n "$ID_TOKEN" > /root/images/sign.id-token
echo -n "$GCP_REGISTRY_LOCATION-docker.pkg.dev/$(gcloud config get core/project)/$GCP_REGISTRY_NAME" > /root/images/repo
echo -n "$GCP_REGISTRY_LOCATION-docker.pkg.dev/$(gcloud config get core/project)" > /root/images/registry