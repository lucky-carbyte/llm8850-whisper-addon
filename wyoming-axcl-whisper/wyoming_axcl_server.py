import asyncio
from wyoming.asr import Transcribe
from wyoming.server import AsyncEventHandler, serve_forever
import aiohttp
import json

AXCL_URL = "http://127.0.0.1:8801/recognize"

class Handler(AsyncEventHandler):
    async def handle_event(self, event):
        if event.type == "transcribe":
            audio_path = event.data["file"]

            async with aiohttp.ClientSession() as session:
                async with session.post(
                    AXCL_URL,
                    json={"filePath": audio_path}
                ) as resp:
                    result = await resp.json()

            return Transcribe(text=result.get("recognition", "")).event()

asyncio.run(serve_forever("tcp://0.0.0.0:10200", Handler()))
