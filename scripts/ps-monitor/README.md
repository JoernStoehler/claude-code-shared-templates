# Process Monitor for Claude Code

A real-time monitoring tool that displays active Claude Code processes with their resource usage and working directories.

## Purpose

This tool helps developers:
- Track multiple Claude Code sessions running simultaneously
- Monitor which directories Claude is working in
- See runtime duration and process relationships
- Identify model versions being used
- Debug hung or zombie processes

## Usage

```bash
# Run the monitor
uv run scripts/ps-monitor/ps-monitor.py

# Or if in scripts directory
./ps-monitor/ps-monitor.py
```

The monitor updates every second. Press `Ctrl+C` to exit.

## Display Information

The monitor shows:
- **PID**: Process ID
- **PPID**: Parent process ID  
- **PARENT**: Parent process name
- **TIME**: How long the process has been running
- **WORKING DIRECTORY**: Where Claude is operating
- **ARGS**: Command line arguments (model, flags)

## Features

- Live updates every second
- Clean terminal UI with color coding
- Filters out the monitor itself
- Shows total Claude process count
- Handles process termination gracefully

## Requirements

The script uses PEP 723 inline dependencies:
- `rich` - Terminal UI rendering
- `psutil` - Process information gathering
- `click` - Command line interface

These are automatically installed when running with `uv run`.

## Implementation Notes

- Uses psutil to find processes containing 'claude' in their command
- Extracts working directory with fallback to 'unknown'
- Parses command line arguments to show model versions
- Replaces home directory with ~ for cleaner display

## Future Enhancements

Potential improvements:
- CPU and memory usage display
- Log to file option
- Filter by directory or model
- Process tree visualization
- Historical tracking