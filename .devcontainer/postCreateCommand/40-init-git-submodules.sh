#!/bin/bash
# 40-init-git-submodules.sh
# =========================
# Initializes git submodules if any exist in the repository.

set -e

echo "📚 Initializing git submodules..."
git submodule update --init --recursive
echo "✅ Submodules initialized successfully"