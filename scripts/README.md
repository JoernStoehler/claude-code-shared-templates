# Scripts Directory

This directory contains utility scripts for development and operations.

## Contents

- `ps-monitor/` - Real-time process monitoring for Claude Code sessions
- `mcp-servers/` - MCP (Model Context Protocol) server implementations (future)

## Usage

Scripts are designed to be run with uv for proper environment setup:

```bash
# Run the process monitor
uv run scripts/ps-monitor/ps-monitor.py
```

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