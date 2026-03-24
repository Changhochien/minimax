"""MiniMax Python package — image, speech, video, and music generation."""
from __future__ import annotations

from minimax.api.client import MiniMaxClient
from minimax.image.client import ImageClient
from minimax.music.client import MusicClient
from minimax.speech.client import SpeechClient
from minimax.video.client import VideoClient

__version__ = "0.2.0"
__all__ = ["MiniMaxClient", "ImageClient", "MusicClient", "SpeechClient", "VideoClient"]
