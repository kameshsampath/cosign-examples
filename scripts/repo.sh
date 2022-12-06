#!/bin/bash

set -euo pipefail

REPO=$(gcloud artifacts repositories list --filter="name.basename()=$GCP_REGISTRY_NAME" --format="value(name.basename())")

if [ -z "$REPO" ];
then
  gcloud config set artifacts/location "$GCP_REGISTRY_LOCATION"
  gcloud artifacts repositories create "$GCP_REGISTRY_NAME"\
    --repository-format=docker \
    --description="Hello World Docker Repository"
fi