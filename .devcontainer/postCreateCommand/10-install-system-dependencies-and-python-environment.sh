#!/bin/bash
# ==============================================================================
# 10-install-system-dependencies-and-python-environment.sh
# ==============================================================================
# PURPOSE: Install system dependencies and set up Python development environment
# 
# DESCRIPTION:
#   Installs system-level dependencies required for Python packages (particularly
#   for scientific computing and visualization), Quarto for document processing,
#   and syncs Python project dependencies using uv.
#
# SYSTEM DEPENDENCIES INSTALLED:
#   - libcairo2-dev: Cairo graphics library (required by pycairo/manim)
#   - libpango1.0-dev: Pango text rendering library (required by manimpango)
#   - pkg-config: Helper tool for compiling applications
#   - python3-dev: Python development headers (for building C extensions)
#   - ffmpeg: Video processing (required by manim for animations)
#
# ADDITIONAL TOOLS:
#   - Quarto: Document processing and presentation system
#   - Python dependencies: All project dependencies via uv sync
#
# NOTES:
#   - This script should run after uv is installed (06-install-uv.sh)
#   - Uses uv sync with --all-extras --dev for complete dependency installation
# ==============================================================================

set -e

echo "Installing system dependencies for Python development..."

# Update package list
sudo apt-get update

# Install system dependencies required by Python packages
sudo apt-get install -y \
    libcairo2-dev \
    libpango1.0-dev \
    pkg-config \
    python3-dev \
    ffmpeg

echo "✓ System dependencies installed"

# Install Quarto for document processing and presentations
echo "Installing Quarto..."
QUARTO_VERSION="1.5.57"
wget -q https://github.com/quarto-dev/quarto-cli/releases/download/v${QUARTO_VERSION}/quarto-${QUARTO_VERSION}-linux-amd64.deb
sudo dpkg -i quarto-${QUARTO_VERSION}-linux-amd64.deb
rm quarto-${QUARTO_VERSION}-linux-amd64.deb
echo "✓ Quarto ${QUARTO_VERSION} installed successfully"

# Check if there's a pyproject.toml in the workspace
if [ -f "${WORKSPACE_PATH}/pyproject.toml" ]; then
    echo "Installing Python dependencies..."
    
    # Install Python dependencies using uv
    # --all-extras: Install all optional dependencies
    # --dev: Install development dependencies
    cd "${WORKSPACE_PATH}" && uv sync --all-extras --dev
    
    echo "✓ Python dependencies installed"
else
    echo "ℹ No pyproject.toml found in workspace - skipping Python dependency installation"
fi

echo ""
echo "✓ System dependencies and Python environment setup complete!"