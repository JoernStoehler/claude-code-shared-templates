# Secrets and Configuration

## Environment Variable Management

### GitHub Codespaces
- Secrets are loaded from GitHub repository secrets
- `.env.example` provides defaults for non-secret values
- Key secrets to configure:
  - `OTEL_EXPORTER_OTLP_HEADERS` - Honeycomb API key in format: `x-honeycomb-team=YOUR_API_KEY`
  - `TAVILY_API_KEY` - For web search functionality
  - Other API keys as needed

### Local Development
- Create a `.env` file (gitignored) with actual values
- Copy from `.env.example` as a starting template
- The `reload-env` function in bashrc handles loading

## Telemetry Configuration

Claude Code telemetry is configured by the `claude-code-telemetry` feature. Environment variables set:
```bash
CLAUDE_CODE_ENABLE_TELEMETRY=1
OTEL_SERVICE_NAME=claude-code
OTEL_EXPORTER_OTLP_ENDPOINT=api.eu1.honeycomb.io:443
OTEL_EXPORTER_OTLP_PROTOCOL=grpc
OTEL_METRICS_EXPORTER=otlp
```

To disable telemetry, exclude the `claude-code-telemetry` feature from your devcontainer.json or set the `enabled` option to false.

## Configuration Directory

Claude Code configuration is stored in:
```
$CLAUDE_CONFIG_DIR=/workspaces/{project}/.devcontainer/.claude-config
```

This directory persists:
- OAuth tokens
- User preferences
- Session history

## Reloading Environment

To reload environment variables during a session:
```bash
reload-env
```

This function automatically detects the environment and loads the appropriate file.

## Security Notes

- Never commit `.env` files
- Use GitHub secrets for Codespaces
- The `.env.example` should contain safe defaults
- API keys should use environment variable references in Codespaces