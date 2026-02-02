#!/usr/bin/env bash
set -e

MODEL_SIZE="${MODEL_SIZE:-base}"       # tiny, small, base
LANGUAGE="${LANGUAGE:-de}"
MODEL_PATH_BASE="${MODEL_PATH_BASE:-/share/llm8850/models}"

MODEL_DIR="${MODEL_PATH_BASE}/whisper-${MODEL_SIZE}"

if [ ! -d "$MODEL_DIR" ]; then
  echo "ERROR: Missing model folder: $MODEL_DIR"
  exit 1
fi

echo "Using Whisper model: $MODEL_SIZE"
echo "Model directory: $MODEL_DIR"

# Rewrite arguments.json
sed \
  -e "s|__MODEL_DIR__|${MODEL_DIR}|g" \
  -e "s|__MODEL_TYPE__|${MODEL_SIZE}|g" \
  -e "s|__LANGUAGE__|${LANGUAGE}|g" \
  /opt/app/arguments.json > /opt/app/arguments.effective.json

# Launch AXCL Whisper server (port 8801)
cd /opt/app/whisper.axcl
(AXCL_ARGS="/opt/app/arguments.effective.json" bash ./serve.sh &) 

sleep 3

# Launch Wyoming bridge (port 10200)
python3 /opt/app/wyoming_axcl_server.py
