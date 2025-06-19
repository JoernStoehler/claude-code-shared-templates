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

Claude Code telemetry can be configured through environment variables. To enable telemetry, add the following to your `.env` file or GitHub secrets:
```bash
CLAUDE_CODE_ENABLE_TELEMETRY=1
OTEL_SERVICE_NAME=claude-code
OTEL_EXPORTER_OTLP_ENDPOINT=api.eu1.honeycomb.io:443
OTEL_EXPORTER_OTLP_PROTOCOL=grpc
OTEL_METRICS_EXPORTER=otlp
```

To disable telemetry, set `CLAUDE_CODE_ENABLE_TELEMETRY=0` or omit the telemetry environment variables.

## Configuration Directory

Claude Code configuration is automatically set up by the `03-bashrc-setups-claude-code-config-dir-in-workspace.sh` script:
```
# Set to workspace-relative path
$CLAUDE_CONFIG_DIR=$WORKSPACE_PATH/.claude-config
```

This directory persists:
- OAuth tokens
- User preferences  
- Session history

**Note**: The configuration directory is automatically created and added to .gitignore to prevent committing sensitive data. The `WORKSPACE_PATH` variable ensures it works reliably in both Codespaces and local environments.

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