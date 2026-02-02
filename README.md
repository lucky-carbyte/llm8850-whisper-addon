# LLM8850 Whisper – Home Assistant Add-On
This repository contains a Home Assistant add-on providing **LLM‑8850 accelerated Whisper ASR** using:

- Axera AXCL runtime
- M5Stack Whisper Base AXMODEL
- whisper.axcl continuous REST transcription server
- Wyoming protocol bridge for Home Assistant Assist

This add-on uses the **Whisper‑Base AXMODEL** (natively compiled for the AXERA AX8850 NPU) and exposes a Wyoming STT service on:   tcp://HOME_ASSISTANT_IP:10200

Works with:
- Home Assistant Assist
- Piper TTS
- Wyoming Satellites
- Any STT consumer that supports Wyoming

---

## 🔧 Installation

1. Open Home Assistant → **Settings → Add-ons → Add-on Store**
2. Click **⋮ (three dots)** → **Repositories**
3. Add:

https://github.com/YOUR_USER/llm8850-whisper-addon
4. Install **Wyoming AXCL Whisper (LLM‑8850)**

---

## ⚙️ Requirements

- Raspberry Pi 5 or x86_64 device running **LLM‑8850 accelerator card**
- Home Assistant OS / Supervised
- M5Stack Whisper Base AXMODEL:

You will place the downloaded AXMODEL models like this:
* /share/llm8850/models/whisper-tiny/
* /share/llm8850/models/whisper-small/
* /share/llm8850/models/whisper-base/

Each must contain:
* ax650/encoder.axmodel
* ax650/decoder-main.axmodel
* ax650/decoder-loop.axmodel
* positional_embedding.bin
* tokens.txt

This matches the HuggingFace Axmodel repository layouts.

Clone the model:

```bash
mkdir -p /share/llm8850/models/whisper-{base,tiny,small}
git clone https://huggingface.co/M5Stack/whisper-base-axmodel /share/llm8850/models/whisper-base
git clone https://huggingface.co/M5Stack/whisper-tiny-axmodel /share/llm8850/models/whisper-tiny
git clone https://huggingface.co/M5Stack/whisper-small-axmodel /share/llm8850/models/whisper-small

🔌 Configure Home Assistant Assist

Go to Settings → Voice Assistants
Add a Wyoming Speech-to-Text provider:

Host: 127.0.0.1
Port: 10200


Select this provider in your Assist pipeline.


📡 API Endpoints

AXCL Whisper Server (internal): http://127.0.0.1:8801/recognize
Wyoming STT: tcp://0.0.0.0:10200


🏁 Start / Stop
Start via Add-on UI.
The add-on launches:

AXCL Whisper server
Wyoming bridge


✔ Features

Hardware-accelerated ASR using Axera AX8850
Ultra‑low CPU load
Home Assistant Wyoming STT provider
Automatic multi-language detection (default: German)


## 🔀 Model Switcher

The add-on supports the following Whisper AXMODEL builds:

- whisper-tiny (fastest, lightest)
- whisper-small (balanced)
- whisper-base (best accuracy)

Place them under:
/share/llm8850/models/whisper-tiny/
/share/llm8850/models/whisper-small/
/share/llm8850/models/whisper-base/

📄 License
MIT
