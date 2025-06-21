#!/bin/bash
# ==============================================================================
# 06-install-uv.sh
# ==============================================================================
# PURPOSE: Install uv, the fast Python package manager
# 
# DESCRIPTION:
#   Installs uv using the official installation script. uv is a Rust-based
#   Python package manager that's significantly faster than pip and provides
#   better dependency resolution.
#
# INSTALLATION METHOD:
#   - Downloads and runs the official installer from astral.sh
#   - Installs to /usr/local/bin for system-wide availability
#   - No sudo required for future package operations
#
# POST-INSTALL:
#   - 'uv' command available globally
#   - Can manage Python packages with commands like:
#     - uv pip install package
#     - uv sync (for pyproject.toml dependencies)
#     - uv run python script.py (runs in virtual environment)
# ==============================================================================

set -e

echo "Installing uv package manager..."

# Check if uv is already installed
if command -v uv &> /dev/null; then
    echo "ℹ uv is already installed: $(uv --version)"
    echo "  Skipping installation"
    exit 0
fi

# Download and run the official installer
# The installer automatically detects the platform and installs the appropriate binary
curl -LsSf https://astral.sh/uv/install.sh | sh

# Move uv to a system-wide location
# The installer puts it in ~/.local/bin by default
if [ -f "$HOME/.local/bin/uv" ]; then
    sudo mv "$HOME/.local/bin/uv" /usr/local/bin/
    echo "✓ Moved uv to /usr/local/bin/"
fi

# Verify installation
if command -v uv &> /dev/null; then
    UV_VERSION=$(uv --version)
    echo "✓ uv installed successfully: $UV_VERSION"
    
    # Show helpful information
    echo ""
    echo "Quick reference:"
    echo "  • Install packages: uv pip install <package>"
    echo "  • Sync project deps: uv sync"
    echo "  • Run with venv: uv run python script.py"
    echo "  • Create new project: uv init"
else
    echo "❌ uv installation failed - command not found after installation"
    exit 1
fi