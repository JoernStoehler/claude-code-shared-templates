# Telemetry and Monitoring

This document explains how telemetry and monitoring work in this project.

## Key Files

- @/scripts/ps-monitor - The only monitoring script (self-documenting)
- @/CLAUDE.md - Contains note about Bash() blocking behavior (search for "Bash() blocks")

## How Telemetry Works

### Default Configuration

Claude Code automatically sends telemetry to Honeycomb:
- `OTEL_EXPORTER_OTLP_ENDPOINT=api.eu1.honeycomb.io:443`
- `OTEL_EXPORTER_OTLP_HEADERS=x-honeycomb-team=${HONEYCOMB_API_KEY}`
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

Use `ps-monitor` to see active Claude processes:

```bash
./scripts/ps-monitor.py
```

Shows:
- PID
- Runtime (how long the process has been running)
- Working directory
- Total active sessions

Press Ctrl+C to quit.

**Limitations**: Cannot show request counts or token usage (use Honeycomb for that)

### Full Telemetry (Honeycomb)

1. Ensure `HONEYCOMB_API_KEY` is set in your `.env`
2. View at: https://ui.honeycomb.io/YOUR_TEAM/datasets/claude-code

## The Only Script: ps-monitor

We have exactly one monitoring script:
- `ps-monitor` - Shows active Claude processes using `ps`

That's it. KISS principle in action.

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
- Verify telemetry enabled: `echo $CLAUDE_CODE_ENABLE_TELEMETRY` (should be "1")

### Monitor blocks forever
- Don't run monitors with Bash() tool - see @/CLAUDE.md for details
- Run in separate terminal instead

## For New Developers

1. **Quick process check**: `ps aux | grep claude`
2. **Monitor multiple sessions**: Run `./scripts/ps-monitor` in separate terminal
3. **Detailed metrics**: Use Honeycomb dashboard
4. **Total learning time**: ~2 minutes