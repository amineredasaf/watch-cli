#!/bin/bash

set -e

echo "🔧 Installing required packages..."

# Detect OS type
if grep -qi microsoft /proc/version; then
    echo "🪟 Detected WSL environment"
else
    echo "🐧 Detected Linux environment"
fi

# Update and install core tools
sudo apt update && sudo apt install -y \
    fzf \
    curl \
    unzip \
    libfuse2 \
    chafa \
    mpv \
    xdg-utils

# Install pup (HTML parser)
echo "🌐 Installing pup..."
PUP_VERSION="v0.4.0"
PUP_URL="https://github.com/ericchiang/pup/releases/download/$PUP_VERSION/pup_${PUP_VERSION}_linux_amd64.zip"

mkdir -p ~/.local/bin
cd /tmp
curl -LO "$PUP_URL"
unzip -o "pup_${PUP_VERSION}_linux_amd64.zip"
chmod +x pup
mv pup ~/.local/bin/

# Add ~/.local/bin to PATH if not already
if ! echo "$PATH" | grep -q "$HOME/.local/bin"; then
    echo "export PATH=\"\$HOME/.local/bin:\$PATH\"" >> ~/.bashrc
    echo "⚠️ Added ~/.local/bin to PATH. Please restart your terminal or run:"
    echo "   source ~/.bashrc"
fi

echo "✅ All dependencies installed!"

