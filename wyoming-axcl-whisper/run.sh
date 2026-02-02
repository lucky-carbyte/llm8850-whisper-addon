#!/usr/bin/env bash
set -e

MODEL_DIR="${MODEL_DIR:-/share/llm8850/models/whisper-base}"
LANGUAGE="${LANGUAGE:-de}"

# patch language into arguments.json
jq --arg lang "$LANGUAGE" '.language=$lang' /opt/app/arguments.json \
  > /opt/app/arguments.effective.json

# start AXCL Whisper server
cd /opt/app/whisper.axcl
(AXCL_ARGS="/opt/app/arguments.effective.json" bash ./serve.sh &) 

sleep 3

# start Wyoming STT bridge
python3 /opt/app/wyoming_axcl_server.py
