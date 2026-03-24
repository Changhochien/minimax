#!/bin/bash
# Install minimax CLI tool
#
# Usage:
#   gh repo clone Changhochien/minimax && cd minimax
#   ./install.sh --key YOUR_KEY              # Global API (default)
#   ./install.sh --key YOUR_KEY --host cn     # Mainland China API
#
# Installs the minimax CLI via uv tool and saves API key to ~/.config/minimax/creds.toml.

set -e

echo "=== minimax installer ==="
echo ""

# Check for uv
if ! command -v uv &>/dev/null; then
    echo "Error: uv is required. Install: https://github.com/astral-sh/uv"
    exit 1
fi

# Parse arguments
API_KEY=""
HOST="global"
while [[ $# -gt 0 ]]; do
    case $1 in
        --key)
            API_KEY="$2"
            shift 2
            ;;
        --key=*)
            API_KEY="${1#*=}"
            shift
            ;;
        --host)
            HOST="$2"
            shift 2
            ;;
        --host=*)
            HOST="${1#*=}"
            shift
            ;;
        *)
            echo "Unknown option: $1"
            echo "Usage: $0 [--key <KEY>] [--host global|cn]"
            exit 1
            ;;
    esac
done

if [ -z "$API_KEY" ]; then
    echo "Error: API key is required. Run: $0 --key YOUR_KEY"
    exit 1
fi

if [ "$HOST" != "global" ] && [ "$HOST" != "cn" ]; then
    echo "Error: --host must be 'global' or 'cn'"
    exit 1
fi

echo "Installing minimax CLI..."
uv tool install --from "git+https://github.com/Changhochien/minimax" minimax

# Save API key and host to config file
CONFIG_DIR="$HOME/.config/minimax"
mkdir -p "$CONFIG_DIR"
cat > "$CONFIG_DIR/creds.toml" <<EOF
MINIMAX_API_KEY=$API_KEY
MINIMAX_API_HOST=$HOST
EOF

if [ "$HOST" = "cn" ]; then
    echo "Using Mainland China API endpoint (api.minimaxi.com)"
else
    echo "Using Global API endpoint (api.minimax.io)"
fi

echo ""
echo "=== Done ==="
echo "Config saved to ~/.config/minimax/creds.toml"
echo ""
echo "Usage:"
echo "  minimax image generate --prompt 'A rubber belt' --aspect-ratio 16:9"
echo "  minimax speech synthesize --text 'Hello' --voice-id Deep_Voice_Man"
echo "  minimax video generate --prompt 'Conveyor belt in motion'"
echo "  minimax music generate --prompt 'Upbeat corporate' --instrumental"
echo ""
echo "Add skills to your project .claude/skills/ directory to have Claude Code use these commands."
