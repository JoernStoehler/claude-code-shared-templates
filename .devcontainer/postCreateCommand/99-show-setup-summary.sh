#!/bin/bash
# 99-show-setup-summary.sh
# ========================
# Shows a summary of the setup including tool locations
# and any relevant status information.

set -e

echo "✅ Setup complete!"

# Show telemetry status if configured
if [ -n "$CLAUDE_CODE_ENABLE_TELEMETRY" ]; then
    echo "🔍 Telemetry configured for: ${OTEL_EXPORTER_OTLP_ENDPOINT:-not set}"
fi

# Show installed tool locations
echo "📍 Tool locations:"
echo "   Claude Code: $(which claude-code 2>/dev/null || echo 'not found in PATH yet - restart shell')"
if [ -f "pyproject.toml" ]; then
    echo "   UV: $(which uv 2>/dev/null || echo 'not found in PATH yet - restart shell')"
fi