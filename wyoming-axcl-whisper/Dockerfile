FROM debian:12-slim

ENV DEBIAN_FRONTEND=noninteractive \
    PYTHONUNBUFFERED=1

RUN apt-get update && apt-get install -y --no-install-recommends \
    ca-certificates git cmake g++ make python3 python3-pip curl \
    libsndfile1 ffmpeg jq \
 && rm -rf /var/lib/apt/lists/*

WORKDIR /opt/app

# Clone and build whisper.axcl (LLM8850 accelerated whisper)
RUN git clone https://github.com/PiSugar/whisper.axcl.git whisper.axcl \
 && cd whisper.axcl \
 && ./build.sh

COPY requirements.txt .
RUN pip3 install --no-cache-dir -r requirements.txt

COPY wyoming_axcl_server.py .
COPY arguments.json .
COPY run.sh .

RUN chmod +x run.sh

EXPOSE 10200

CMD ["/opt/app/run.sh"]
