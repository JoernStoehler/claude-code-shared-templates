#!/bin/bash
# ==============================================================================
# 02-bashrc-setups-claude-code-telemetry.sh
# ==============================================================================
# PURPOSE: Configure OpenTelemetry environment variables for Claude Code telemetry
# 
# DESCRIPTION:
#   Sets up telemetry configuration for Claude Code to send usage metrics to
#   Honeycomb. This enables monitoring of Claude Code usage patterns and helps
#   identify performance issues.
#
# REQUIRED ENVIRONMENT VARIABLES:
#   - HONEYCOMB_API_KEY: Honeycomb ingest key for EU region
#   - HONEYCOMB_DATASET: Dataset name in Honeycomb
#
# SETS ENVIRONMENT VARIABLES:
#   - CLAUDE_CODE_ENABLE_TELEMETRY=1
#   - OTEL_METRICS_EXPORTER=otlp
#   - OTEL_LOGS_EXPORTER=otlp
#   - OTEL_EXPORTER_OTLP_PROTOCOL=grpc
#   - OTEL_EXPORTER_OTLP_ENDPOINT=https://api.honeycomb.io:443
#   - OTEL_EXPORTER_OTLP_HEADERS (computed from HONEYCOMB_* vars)
#
# REFERENCE: https://docs.anthropic.com/en/docs/claude-code/monitoring-usage
# ==============================================================================

set -e

echo "Configuring Claude Code telemetry in ~/.bashrc..."

# Add telemetry configuration to ~/.bashrc
cat >> ~/.bashrc << 'EOF'

# Claude Code telemetry configuration
if [ -n "$HONEYCOMB_API_KEY" ] && [ -n "$HONEYCOMB_DATASET" ]; then
    export CLAUDE_CODE_ENABLE_TELEMETRY=1
    export OTEL_METRICS_EXPORTER=otlp
    export OTEL_LOGS_EXPORTER=otlp
    export OTEL_EXPORTER_OTLP_PROTOCOL=grpc
    export OTEL_EXPORTER_OTLP_ENDPOINT=https://api.honeycomb.io:443
    export OTEL_EXPORTER_OTLP_HEADERS="x-honeycomb-dataset=${HONEYCOMB_DATASET},x-honeycomb-team=${HONEYCOMB_API_KEY}"
    echo "✓ Claude Code telemetry configured"
else
    if [ -z "$HONEYCOMB_API_KEY" ] && [ -z "$HONEYCOMB_DATASET" ]; then
        echo "ℹ Claude Code telemetry disabled (HONEYCOMB_API_KEY and HONEYCOMB_DATASET not set)"
    elif [ -z "$HONEYCOMB_API_KEY" ]; then
        echo "⚠ Claude Code telemetry disabled (HONEYCOMB_API_KEY not set)"
    else
        echo "⚠ Claude Code telemetry disabled (HONEYCOMB_DATASET not set)"
    fi
fi
EOF

echo "✓ Claude Code telemetry configuration added to ~/.bashrc"