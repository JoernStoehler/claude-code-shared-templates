#!/bin/bash
# install-language-deps.sh
# ========================
# Detects and installs language-specific dependencies based on
# project files (package.json, pyproject.toml, etc.)
#
# Used by: postCreateCommand.sh

set -e

echo "🔍 Detecting and installing language dependencies..."

# Python projects
if [ -f "pyproject.toml" ] || [ -f "requirements.txt" ]; then
    echo "🐍 Python project detected, installing uv..."
    curl -LsSf https://astral.sh/uv/install.sh | sh
    
    if [ -f "pyproject.toml" ] && command -v uv &> /dev/null; then
        echo "📚 Installing Python dependencies..."
        uv sync --frozen --all-extras --dev || uv sync --all-extras --dev || echo "⚠️ UV sync failed - manual setup may be required"
    fi
fi

# Node.js projects
if [ -f "package.json" ]; then
    echo "📦 Node.js project detected, installing dependencies..."
    if [ -f "package-lock.json" ]; then
        npm ci
    elif [ -f "yarn.lock" ]; then
        yarn install --frozen-lockfile
    elif [ -f "pnpm-lock.yaml" ]; then
        pnpm install --frozen-lockfile
    else
        npm install
    fi
fi

# Install pre-commit hooks if config exists
if [ -f ".pre-commit-config.yaml" ]; then
    echo "🔗 Installing pre-commit hooks..."
    if command -v uv &> /dev/null; then
        # Try to install hooks with uv first
        if uv run pre-commit install && uv run pre-commit install --hook-type commit-msg; then
            echo "✅ Pre-commit hooks installed with uv"
        else
            # Fallback to pip if uv fails
            pip install pre-commit && pre-commit install && pre-commit install --hook-type commit-msg
        fi
    else
        pip install pre-commit && pre-commit install && pre-commit install --hook-type commit-msg
    fi
fi

echo "✅ Language dependencies installed"