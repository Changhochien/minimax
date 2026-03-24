"""MiniMax music generation API client."""
from __future__ import annotations

from typing import Any

from ..api.client import MiniMaxClient


class MusicClient:
    """Client for MiniMax music generation API (music-2.5+)."""

    MUSIC_ENDPOINT = "/music_generation"
    LYRICS_ENDPOINT = "/lyrics_generation"

    def __init__(self, client: MiniMaxClient) -> None:
        self._client = client

    async def generate(
        self,
        prompt: str,
        *,
        lyrics: str | None = None,
        model: str = "music-2.5+",
        is_instrumental: bool = False,
        lyrics_optimizer: bool = False,
        stream: bool = False,
        output_format: str = "hex",
        audio_setting: dict[str, Any] | None = None,
    ) -> dict[str, Any]:
        """
        Generate a music track via MiniMax music-2.5+ model.

        Two modes:
        - Text-to-Music: provide only prompt (lyrics_optimizer=true for auto-generated lyrics)
        - Full song: provide prompt + lyrics with structural tags ([Verse], [Chorus], etc.)
        """
        payload: dict[str, Any] = {
            "model": model,
            "prompt": prompt,
            "is_instrumental": is_instrumental,
            "lyrics_optimizer": lyrics_optimizer,
            "stream": stream,
            "output_format": output_format,
        }

        if lyrics:
            payload["lyrics"] = lyrics
        if audio_setting:
            payload["audio_setting"] = audio_setting

        result = await self._client.post(self.MUSIC_ENDPOINT, json=payload)
        return result

    async def generate_lyrics(
        self,
        prompt: str,
        *,
        mode: str = "write_full_song",
    ) -> dict[str, Any]:
        """
        Generate song lyrics from a text description.

        Use this first, then pass the result to generate() as the lyrics param.
        """
        payload: dict[str, Any] = {
            "prompt": prompt,
            "mode": mode,
        }
        result = await self._client.post(self.LYRICS_ENDPOINT, json=payload)
        return result
