# Claude Repository Management Tools

## Overview

This directory contains two complementary tools for managing repositories in Claude Code development:

- **`claude-worktree`** - Creates and manages git worktrees within a repository
- **`claude-clone`** - Clones additional repositories into `/workspaces/` for multi-repo development

Together, these tools enable efficient parallel development across multiple projects and branches.

## Claude Worktree Tool

The `claude-worktree` script wraps these repetitive commands:
```bash
# Manual process
git worktree add /workspaces/feat-auth -b feat/auth
cd /workspaces/feat-auth
uv sync --all-extras
code --add /workspaces/feat-auth
claude --dangerously-skip-permissions

# With claude-worktree
claude-worktree create feat/auth
# Copy/paste the printed command
```

## Commands

### claude-worktree create <branch-name>

Creates a new worktree with the specified branch:
1. Validates current directory has no uncommitted changes
2. Checks branch doesn't already exist (locally or remote)
3. Runs `git worktree add /workspaces/{branch-name} -b {branch-name}`
4. Runs `uv sync --all-extras` if Python project
5. Runs `code --add` to add to VS Code
6. Prints command to start Claude

### claude-worktree remove <path-or-branch>

Safely removes a worktree:
1. Accepts branch name or full path
2. Checks for uncommitted changes
3. Runs `git worktree remove`
4. Reminds about VS Code cleanup

### claude-worktree status

Shows all workspaces with:
- Repository and branch info (supports both regular repos and git worktrees)
- Claude process detection (checks process working directories via `/proc/PID/cwd`)
- Memory usage for running Claude processes
- Last git activity time (without filename to fit 80-column terminals)

Example output:
```
WORKSPACE                 REPO            BRANCH             CLAUDE ACTIVITY
--------------------------------------------------------------------------------
fix-claude-worktree-st... seminar-ki      fix/claude-workt... ✓ .2G 7h ago
fix-no-honeycomb-data     seminar-ki      fix/no-honeycomb... ✓ .2G 4m ago
fix-review                otel-cf         fix/review         ✓ .2G 22m ago
otel-cloudflare-collector otel-cf         main               ✗    22m ago
seminar-ki-in-der-math... seminar-ki      main               ✗    7h ago
```

## Claude Clone Tool

The `claude-clone` script manages cloning additional repositories into `/workspaces/` for multi-repository development.

### claude-clone clone <repo> [name]

Clones a repository using GitHub CLI:
1. Validates `gh` is installed and authenticated
2. Accepts multiple repository formats:
   - `https://github.com/user/repo.git`
   - `git@github.com:user/repo.git`
   - `user/repo` (GitHub shorthand)
3. Clones to `/workspaces/{repo-name}` (or custom name)
4. Runs `uv sync --all-extras` for Python projects
5. Runs `npm install` for Node.js projects
6. Adds to VS Code workspace
7. Prints command to start Claude

Example:
```bash
claude-clone clone anthropics/claude-code
claude-clone clone user/private-repo my-custom-name
```

### claude-clone remove <repo-name>

Safely removes a cloned repository:
1. Checks it's not a worktree (use `claude-worktree remove` for those)
2. Checks for uncommitted changes
3. Warns about unpushed commits
4. Removes the repository directory

### claude-clone status

Shows all repositories and worktrees in `/workspaces/`:
- Repository type (clone vs worktree)
- Remote repository info
- Current branch
- Status (modified/unpushed/behind/clean)

Example output:
```
REPOSITORY                TYPE       REMOTE               BRANCH               STATUS
------------------------------------------------------------------------------------------
feat-separate-environment worktree   JoernStoehler/sem... feat-separate-env... modified 
claude-code-templates     clone      anthropics/claud...  main                 clean
my-project                clone      user/my-project      develop              unpushed 
```

## Implementation

Both scripts are pure bash with:
- Clear error messages using color codes
- Safety checks before operations
- Helpful suggestions when things go wrong

### claude-worktree key functions:
- `check_git_repo()` - Ensures we're in a git repository
- `create_worktree()` - Main creation logic with validations
- `remove_worktree()` - Safe removal with branch/path resolution
- `show_status()` - Parses git and process info for display

### claude-clone key functions:
- `check_gh_auth()` - Validates GitHub CLI authentication
- `parse_repo_reference()` - Handles various repository URL formats
- `clone_repository()` - Clones with dependency installation
- `remove_repository()` - Safe removal with validation
- `show_status()` - Shows all repos and their states

## Installation

The setup script (`11-setup-claude-shortcuts.sh`) adds the script directory to PATH:
```bash
export PATH="${WORKSPACE_PATH}/scripts/worktree-manager:$PATH"
```

This makes both `claude-worktree` and `claude-clone` available from anywhere.

## Error Handling

The script provides clear, actionable error messages:
```bash
Error: Branch 'feat/auth' already exists locally
To use existing branch: git worktree add /workspaces/feat-auth feat/auth

Error: Worktree has uncommitted changes
Please commit or stash changes first:
  cd /workspaces/feat-old
  git status
```

## Why Bash?

- Simple wrapper around git commands
- No dependencies beyond standard tools
- Easy to understand and modify
- Clear mapping to underlying commands
- Fast execution

## Technical Notes

### Git Worktree Detection
The script detects both regular git repositories (with `.git` directory) and git worktrees (with `.git` file). This is done by checking `-e "$dir/.git"` instead of `-d "$dir/.git"`.

### Claude Process Detection
Instead of searching for directory paths in the process command line, the script:
1. Uses `pgrep -x claude` to find all Claude processes
2. Reads each process's working directory from `/proc/$pid/cwd`
3. Matches against workspace directories
4. Retrieves memory usage via `ps -p $pid -o rss=`

### Compact Display Format
To fit within 80-column terminals, the status display:
- Abbreviates known repository names (e.g., "seminar-ki" instead of full name)
- Truncates long workspace and branch names intelligently
- Omits filenames from the activity column
- Uses fixed column widths for consistent alignment