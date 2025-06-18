#!/bin/bash
# 15-create-env-reload-function.sh
# ================================
# Creates the reload-env function in .bashrc that dynamically
# loads environment variables from .env files based on context
# (Codespaces vs local development).
# 
# NOTE: Core Claude environment variables are now set by the 
# claude-code-environment feature. This script handles project-specific
# environment variables.

set -e

echo "💾 Creating environment loading function..."

# Create reload-env function in bashrc
cat >> ~/.bashrc << 'EOF'

# Dynamic environment loading function for project-specific variables
reload-env() {
    local env_file
    
    # Determine which env file to use
    if [ -n "$CODESPACES" ]; then
        env_file=".env.example"
        echo "📍 Running in GitHub Codespaces"
    else
        echo "📍 Running in local devcontainer"
        # Use .env if it exists, otherwise fall back to .env.example
        if [ -f ".env" ]; then
            env_file=".env"
            echo "✅ Using .env"
        else
            env_file=".env.example"
            echo "⚠️  No .env found, using .env.example (remember to create .env with real values)"
        fi
    fi
    
    # Check if the env file exists
    if [ -f "$env_file" ]; then
        echo "📝 Loading environment variables from $env_file"
        set -a
        source "$env_file"
        set +a
        echo "✅ Environment variables loaded successfully"
    else
        echo "⚠️  Environment file $env_file not found"
    fi
}

# Auto-load env vars on shell startup
reload-env
EOF

# Load environment variables for the current setup session
if [ -n "$CODESPACES" ]; then
    ENV_FILE=".env.example"
else
    if [ -f ".env" ]; then
        ENV_FILE=".env"
    else
        ENV_FILE=".env.example"
    fi
fi

if [ -f "$ENV_FILE" ]; then
    set -a
    source "$ENV_FILE"
    set +a
fi

echo "✅ Environment loading function created"