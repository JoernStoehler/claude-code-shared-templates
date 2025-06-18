#!/bin/bash
# postCreateCommand.sh
# ====================
# Entry point that runs all numbered setup scripts in order.
# Scripts are in .devcontainer/postCreateCommand/ directory.

set -e

echo "🚀 Setting up universal development environment..."

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Run all numbered scripts in order
for script in "$SCRIPT_DIR"/postCreateCommand/[0-9][0-9]-*.sh; do
    if [ -f "$script" ] && [ -x "$script" ]; then
        echo ""
        echo "Running: $(basename "$script")"
        "$script"
    fi
done