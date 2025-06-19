# Scripts Directory

This directory contains utility scripts for development and operations.

## Contents

- `ps-monitor/` - Real-time process monitoring for Claude Code sessions
- `migrate-claude-config.sh` - Migrates Claude Code config to persistent location
- `mcp-servers/` - MCP (Model Context Protocol) server implementations (future)

## Usage

Scripts are designed to be run with uv for proper environment setup:

```bash
# Run the process monitor
uv run scripts/ps-monitor/ps-monitor.py

# Migrate Claude config to persistent location
./scripts/migrate-claude-config.sh
```

### Claude Config Migration

If you're experiencing issues with Claude Code configuration not persisting across container rebuilds, run the migration script. This will move your configuration from the ephemeral home directory to the workspace directory where it will persist.

## Adding New Scripts

When adding new scripts:

1. Create a subdirectory with a descriptive name
2. Place the script in the subdirectory  
3. Include a README.md documenting:
   - Purpose and functionality
   - Usage instructions
   - Any dependencies or requirements
   - Examples

## Script Standards

- Use shebang line: `#!/usr/bin/env -S uv run`
- Include inline dependencies using PEP 723 format
- Make scripts executable: `chmod +x script.py`
- Write clear help text and usage examples
- Follow project coding standards