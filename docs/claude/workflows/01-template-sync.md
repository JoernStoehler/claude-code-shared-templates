# Template Synchronization Workflows

## Overview

The template synchronization system enables bidirectional flow of improvements between the template repository and derived projects. This ensures all projects benefit from enhancements made in any project.

## Important Concepts

### Template Repositories Are Independent
- Template repositories have **completely separate git histories**
- They are **not forks** - there's no shared commit ancestor
- You **cannot** use git merge, cherry-pick, or rebase between them
- You **must** copy files, not git commits

### Two-Way Sync
1. **Pull from template**: Get improvements from the template
2. **Push to template**: Share your improvements back

## One-Time Setup

Clone the template repository once:

```bash
cd /workspaces
git clone $CLAUDE_TEMPLATE_REPO_URL
# The template URL is set in devcontainer.json:
# https://github.com/JoernStoehler/claude-code-shared-templates.git
```

This clone will be used with worktrees for all template operations.

## Pulling Updates from Template

To get updates from the template, use the cloned repository:

### 1. Update Template Clone

```bash
cd /workspaces/claude-code-shared-templates
git fetch origin
git pull origin main
```

### 2. Review and Copy Updates

#### Option A: Direct Copy from Main
```bash
# Compare specific files
diff CLAUDE.md /workspaces/your-project-name/CLAUDE.md

# Copy improved files to your project
cp docs/claude/workflows/new-workflow.md \
   /workspaces/your-project-name/docs/claude/workflows/

# Or use VS Code to compare
code --diff CLAUDE.md /workspaces/your-project-name/CLAUDE.md
```

#### Option B: Create Review Worktree
```bash
# If you want to review changes in a separate directory
git worktree add /workspaces/template-review

cd /workspaces/template-review
# Review files, copy what you need

# Clean up when done
cd /workspaces/claude-code-shared-templates
git worktree remove /workspaces/template-review
```

### 3. Commit Updates to Your Project

```bash
cd /workspaces/your-project-name
git add -A
git commit -m "chore: sync improvements from template

- Updated workflow documentation
- Improved devcontainer scripts"
```

## Contributing Back to Template

When you've made improvements that would benefit other projects:

### Step 1: Identify Shareable Improvements

Good candidates for template contribution:
- Claude Code workflow improvements
- Devcontainer setup scripts in `.devcontainer/postCreateCommand/`
- General utility scripts (like @scripts/ps-monitor/ps-monitor.py)
- Documentation improvements
- Bug fixes in template code
- Environment setup improvements

Not suitable for template:
- Project-specific business logic
- Domain-specific utilities
- Proprietary code
- Project-specific dependencies

### Step 2: Create Feature Worktree

```bash
cd /workspaces/claude-code-shared-templates

# Create worktree for your improvements
git worktree add /workspaces/feat-improved-docs -b feat/improved-docs
cd /workspaces/feat-improved-docs
```

### Step 3: Copy and Generalize Improvements

```bash
# Copy improvements from your project
cp /workspaces/your-project-name/.devcontainer/postCreateCommand/*.sh \
   .devcontainer/postCreateCommand/

# Copy documentation
cp -r /workspaces/your-project-name/docs/claude/workflows/ \
      docs/claude/

# Generalize the files - replace project-specific content
find . -type f -name "*.md" -exec sed -i 's/your-project-name/your-project-name/g' {} \;
find . -type f -name "*.sh" -exec sed -i 's/your-project-name/{repository-name}/g' {} \;

# Review changes
git diff
git status
```

### Step 4: Commit and Create PR

```bash
# Stage and commit
git add -A
git commit -m "feat: add improved documentation structure

- Add comprehensive worktree workflow docs
- Improve template sync documentation
- Add troubleshooting guides
- Fix bash script error handling"

# Push to origin
git push -u origin feat/improved-docs

# Create PR (gh will handle forking if needed!)
gh pr create \
  --title "Add improved documentation from seminar project" \
  --body "## Summary
This PR adds improved documentation structure developed in the seminar project.

## Changes
- Comprehensive worktree workflow documentation
- Clearer template sync process
- Troubleshooting guides
- Script improvements

## Testing
- Tested in active project
- Documentation reviewed for clarity"
```

### Step 5: Clean Up

```bash
# After PR is merged
cd /workspaces/claude-code-shared-templates
git worktree remove /workspaces/feat-improved-docs

# Update main
git checkout main
git pull origin main
```

## Generalizing Files

When contributing to the template, replace project-specific content:

| Original | Template Version |
|----------|-----------------|
| `your-project-name` | `your-project-name` or `{repository-name}` |
| `/workspaces/your-project-name` | `/workspaces/{repository-name}` |
| Specific API keys | `YOUR_API_KEY_HERE` |
| Specific dependencies | Comment with examples |
| Business logic | Generic examples |

Example transformation:
```python
# Project-specific
PROJECT_NAME = "your-project-name"
PROFESSOR = "Prof. Dr. Müller"

# Template version
PROJECT_NAME = "your-project-name"  # Update this
# PROFESSOR = "Your professor"  # Uncomment and update if needed
```

## Common Patterns

### Syncing Multiple Files

```bash
# In template worktree
cd /workspaces/feat-sync-configs

# Copy multiple config files
for file in .gitignore .env.example Makefile; do
  cp /workspaces/your-project-name/$file .
done

# Generalize all at once
find . -type f -exec sed -i 's/project-specific/generic/g' {} \;
```

### Selective Directory Sync

```bash
# Copy directory structure but exclude specific files
rsync -av \
  --exclude='*.pyc' \
  --exclude='__pycache__' \
  --exclude='project-specific-*' \
  /workspaces/your-project-name/scripts/ \
  ./scripts/
```

### Testing Template Changes

```bash
# Create a test project from your modified template
cd /tmp
git clone /workspaces/feat-new-feature test-template
cd test-template
# Verify everything works for a new project
```

## Best Practices

1. **One-time clone** - Clone template once, use worktrees for everything
2. **Consistent locations** - All worktrees in `/workspaces/`
3. **Descriptive branch names** - `feat/what-you-added`
4. **Generalize thoroughly** - Search for all project-specific strings
5. **Test the template** - Ensure it works for new projects
6. **Small, focused PRs** - One improvement type per PR
7. **Clean up worktrees** - Remove after PR is merged
8. **Keep template updated** - Regular `git pull origin main`

## Quick Reference

```bash
# One-time setup
cd /workspaces && git clone $CLAUDE_TEMPLATE_REPO_URL

# Pull from template
cd /workspaces/claude-code-shared-templates && git pull
cp improved-file /workspaces/your-project-name/

# Contribute to template
cd /workspaces/claude-code-shared-templates
git worktree add /workspaces/feat-name -b feat/name
cd /workspaces/feat-name
# ... copy and generalize files ...
git add -A && git commit -m "feat: description"
git push -u origin feat/name
gh pr create

# Clean up
git worktree remove /workspaces/feat-name
```

## Troubleshooting

For common issues and detailed troubleshooting, see @docs/claude/workflows/04-template-sync-troubleshooting.md

### Key Points to Remember

- **No git operations between repos** - Only file copying works
- **Use worktrees for isolation** - Same pattern as project development
- **Let gh handle forking** - No need for fork remotes
- **Generalize everything** - Remove all project-specific content