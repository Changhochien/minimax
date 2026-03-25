---
name: minimax
description: MiniMax Token Plan CLI for image generation, speech synthesis, video generation, and music generation. Use when asked to "generate an image", "create a product photo", "synthesize speech", "generate a video", "create music", "make a song", or "text to speech".
emoji: 🎨
metadata:
  openclaw:
    requires:
      bins:
        - minimax
    install:
      - id: uv-tool
        kind: sh
        command: uv tool install --from "git+https://github.com/Changhochien/minimax" minimax
---

# minimax

MiniMax Token Plan CLI — image, speech, video, and music generation.

**Requires:** `minimax` CLI and `MINIMAX_API_KEY` in `~/.config/minimax/creds.toml`

---

## Commands

### Image Generation (T2I / I2I)

```bash
minimax image generate --prompt "A rubber belt on white" --aspect-ratio 16:9
minimax image generate --prompt "Same product on dark background" --image ./photo.jpg --aspect-ratio 16:9
minimax image generate --prompt "Same character in a street scene" --image ./character.png --subject-ref ./portrait.jpg
```

### Speech Synthesis (TTS)

```bash
minimax speech synthesize --text "Your order is confirmed." --voice-id Deep_Voice_Man --emotion calm
minimax speech synthesize --text "Welcome to our product line" --voice-id Chinese_Elegant_Speaker
```

### Video Generation (T2V / I2V)

```bash
minimax video generate --prompt "Conveyor belt in motion"
minimax video generate --prompt "Product slowly rotating" --first-frame ./product-shot.jpg
```

### Music Generation

```bash
minimax music generate --prompt "Upbeat corporate background music" --instrumental
minimax music generate --prompt "Dark cinematic underscore" --lyrics "Verse: Night wind..." --auto-lyrics
```

---

## When to Use

- User asks to "generate/create an image", "make a product photo"
- User asks to "synthesize speech", "text to speech", "make it talk"
- User asks to "generate a video", "create a video clip"
- User asks to "create music", "make a song", "generate background music"
