#!/bin/bash
set -e

# Validate required env vars early
if [ -z "$TELEGRAM_BOT_TOKEN" ] || [ -z "$MISTRAL_API_KEY" ]; then
    echo "ERROR: Missing env vars. Set TELEGRAM_BOT_TOKEN and MISTRAL_API_KEY in Render dashboard."
    exit 1
fi

echo "Starting Hermes gateway..."
exec python bot.py
