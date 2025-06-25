# Telemetry and Monitoring

This document explains how telemetry and monitoring work in this project.

## Key Files

- @/scripts/worktree-manager/claude-worktree - Includes process monitoring via `status` command
- @/CLAUDE.md - Contains note about Bash() blocking behavior (search for "Bash() blocks")

## How Telemetry Works

### Default Configuration

Claude Code automatically sends telemetry to Honeycomb:
- Auto-detects region from API key prefix (EU: `hcbik_*`, US: `hcaik_*`)
- Sets appropriate endpoint (api.eu1.honeycomb.io or api.honeycomb.io)
- Uses HTTP/protobuf protocol for reliable delivery
- No local infrastructure needed
- Works across all devcontainers and codespaces

### What Gets Collected

- API request counts
- Token usage
- Error rates
- Performance metrics
- Session traces

## Monitoring Claude Sessions

### Local Process Monitoring

Use `claude-worktree status` to see active Claude processes:

```bash
claude-worktree status
```

Shows:
- Workspace and branch information
- Claude process status (✓ or ✗)
- Memory usage for active processes
- Last git activity

**Limitations**: Cannot show request counts or token usage (use Honeycomb for that)

### Full Telemetry (Honeycomb)

1. Ensure `HONEYCOMB_API_KEY` and `HONEYCOMB_DATASET` are set in your `.env`
2. View at:
   - EU: https://ui.eu1.honeycomb.io/YOUR_TEAM/environments/claude-code
   - US: https://ui.honeycomb.io/YOUR_TEAM/environments/claude-code

## Process Monitoring

Process monitoring is integrated into the worktree management tool:
- `claude-worktree status` - Shows active Claude processes and their workspaces

This follows the KISS principle by combining related functionality.

## Why This Design?

We deliberately keep it simple:
1. **No daemons** - Nothing to start, stop, or debug
2. **Industry standard** - Honeycomb is well-documented
3. **Unix philosophy** - Use `ps` for process monitoring
4. **Zero maintenance** - No custom infrastructure

## Common Issues

### Monitor shows no processes
- Claude not running
- Check with: `ps aux | grep claude`

### No telemetry in Honeycomb
- Check `HONEYCOMB_API_KEY` is set: `echo $HONEYCOMB_API_KEY`
- Check `HONEYCOMB_DATASET` is set: `echo $HONEYCOMB_DATASET`
- Verify telemetry enabled: `echo $CLAUDE_CODE_ENABLE_TELEMETRY` (should be "1")
- Verify correct region endpoint: `echo $OTEL_EXPORTER_OTLP_ENDPOINT`
  - EU keys (hcbik_*): should show `https://api.eu1.honeycomb.io:443`
  - US keys (hcaik_*): should show `https://api.honeycomb.io:443`

### Monitor blocks forever
- Don't run monitors with Bash() tool - see @/CLAUDE.md for details
- Run in separate terminal instead

## For New Developers

1. **Quick process check**: `ps aux | grep claude`
2. **Monitor multiple sessions**: Run `claude-worktree status`
3. **Detailed metrics**: Use Honeycomb dashboard
4. **Total learning time**: ~2 minutes