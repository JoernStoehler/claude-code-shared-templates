#!/usr/bin/env -S uv run
# /// script
# dependencies = [
#   "rich",
#   "psutil",
#   "click",
# ]
# ///
"""ps-monitor - Real-time monitor for Claude processes

Usage: ./scripts/ps-monitor.py

Shows active Claude processes with their resource usage and working directories.
Updates every second. Press Ctrl+C to quit.
"""

import sys
import time
from datetime import datetime
from pathlib import Path

import click
import psutil
from rich import box
from rich.console import Console
from rich.layout import Layout
from rich.live import Live
from rich.panel import Panel
from rich.table import Table
from rich.text import Text

console = Console()


def get_claude_processes():
    """Find all Claude processes."""
    claude_procs = []
    
    for proc in psutil.process_iter(['pid', 'ppid', 'name', 'cmdline', 'cpu_percent', 'memory_percent', 'create_time']):
        try:
            info = proc.info
            cmdline = info.get('cmdline', [])
            
            # Check if this is a Claude process - must be the claude CLI tool
            if cmdline and any('claude' in arg and ('bin/claude' in arg or arg == 'claude' or arg.endswith('/claude')) for arg in cmdline):
                # Skip ps-monitor itself
                if any('ps-monitor' in arg for arg in cmdline):
                    continue
                
                # Get working directory
                try:
                    cwd = proc.cwd()
                    # Replace home with ~
                    home = str(Path.home())
                    if cwd.startswith(home):
                        cwd = '~' + cwd[len(home):]
                except (psutil.AccessDenied, psutil.NoSuchProcess):
                    cwd = 'unknown'
                
                # Parse command line for args
                claude_args = []
                
                # Find the claude executable index
                claude_idx = next((i for i, arg in enumerate(cmdline) if 'claude' in arg and not arg.startswith('-')), -1)
                
                if claude_idx >= 0:
                    # Arguments after 'claude' command
                    remaining_args = cmdline[claude_idx + 1:] if claude_idx + 1 < len(cmdline) else []
                    
                    # Collect interesting flags
                    for i, arg in enumerate(remaining_args):
                        if arg in ['--model', '-m'] and i + 1 < len(remaining_args):
                            model = remaining_args[i+1]
                            # Shorten model names for display
                            if 'claude-3-5-sonnet' in model:
                                claude_args.append('sonnet-3.5')
                            elif 'claude-3-5-haiku' in model:
                                claude_args.append('haiku-3.5')
                            elif 'claude-3-opus' in model:
                                claude_args.append('opus-3')
                            else:
                                claude_args.append(f'model:{model}')
                        elif arg == '--continue':
                            claude_args.append('continue')
                        elif arg == '--no-images':
                            claude_args.append('no-images')
                        elif arg == '--profile':
                            claude_args.append('profile')
                
                # Calculate runtime
                create_time = datetime.fromtimestamp(info['create_time'])
                runtime = datetime.now() - create_time
                runtime_str = str(runtime).split('.')[0]  # Remove microseconds
                
                # Get parent process info
                ppid = info.get('ppid', 0)
                parent_name = 'unknown'
                try:
                    if ppid:
                        parent = psutil.Process(ppid)
                        parent_name = parent.name()
                except (psutil.NoSuchProcess, psutil.AccessDenied):
                    pass
                
                claude_procs.append({
                    'pid': info['pid'],
                    'ppid': ppid,
                    'parent': parent_name,
                    'time': runtime_str,
                    'cwd': cwd,
                    'args': ', '.join(claude_args) if claude_args else 'none'
                })
        except (psutil.NoSuchProcess, psutil.AccessDenied):
            continue
    
    return claude_procs


def create_display():
    """Create the display table."""
    # Header
    header = Panel(
        Text("Claude Process Monitor", justify="center", style="bold"),
        subtitle=Text(datetime.now().strftime('%Y-%m-%d %H:%M:%S'), style="dim"),
        box=box.DOUBLE,
        style="blue",
        padding=(0, 1)
    )
    
    # Process table
    table = Table(
        title_style="bold cyan",
        border_style="dim",
        show_header=True,
        header_style="bold cyan",
        box=box.SIMPLE,
        padding=(0, 1),
        expand=True
    )
    
    table.add_column("PID", style="white", width=8)
    table.add_column("PPID", style="dim", width=8)
    table.add_column("PARENT", style="dim", width=12)
    table.add_column("TIME", width=12)
    table.add_column("WORKING DIRECTORY", style="dim")
    table.add_column("ARGS", style="cyan dim")
    
    processes = get_claude_processes()
    
    for proc in processes:
        table.add_row(
            str(proc['pid']),
            str(proc['ppid']),
            proc['parent'],
            proc['time'],
            proc['cwd'],
            proc['args']
        )
    
    # Footer
    footer = Text(justify="center")
    footer.append("\nTotal Claude processes: ", style="normal")
    footer.append(str(len(processes)), style="green")
    footer.append("\n\n")
    footer.append("Press ", style="dim")
    footer.append("Ctrl+C", style="dim bold")
    footer.append(" to quit  •  Updates every second", style="dim")
    
    # Combine elements
    layout = Layout()
    layout.split_column(
        Layout(header, size=3),
        Layout(table),
        Layout(footer, size=4)
    )
    
    return layout


@click.command()
def main():
    """Run the Claude process monitor."""
    try:
        # Initialize CPU percent monitoring
        for _proc in psutil.process_iter(['cpu_percent']):
            pass
        
        with Live(create_display(), refresh_per_second=1, screen=True) as live:
            while True:
                live.update(create_display())
                time.sleep(1)
                
    except KeyboardInterrupt:
        # Clean exit on Ctrl+C
        console.print("\n[dim]Exiting...[/dim]")
    except Exception as e:
        console.print(f"\n[red]Error: {e}[/red]")
        sys.exit(1)


if __name__ == "__main__":
    main()