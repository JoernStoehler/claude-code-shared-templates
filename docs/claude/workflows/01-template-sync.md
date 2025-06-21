# Template Synchronization Workflows

## Overview

The template synchronization system enables bidirectional flow of improvements between the template repository and derived projects. This ensures all projects benefit from enhancements made in any project.

## Setup

The template repository remote is automatically configured by the devcontainer setup script `08-add-template-remote.sh`. This enables bidirectional synchronization of improvements between projects.

### Automatic Setup

The template remote is added automatically during devcontainer creation:
- Remote name: `template`
- URL: `https://github.com/JoernStoehler/claude-code-shared-templates.git`
- Script: `.devcontainer/postCreateCommand/08-add-template-remote.sh`

### Manual Setup (if needed)

If the automatic setup didn't run or you need to add it manually:

```bash
# Add template remote
git remote add template https://github.com/JoernStoehler/claude-code-shared-templates.git

# Verify template remote exists
git remote -v

# Should show:
# origin    https://github.com/YourOrg/your-project.git (fetch)
# origin    https://github.com/YourOrg/your-project.git (push)
# template  https://github.com/JoernStoehler/claude-code-shared-templates.git (fetch)
# template  https://github.com/JoernStoehler/claude-code-shared-templates.git (push)
```

## Common Sync Workflows

### 1. Pull Updates from Template

To incorporate latest template improvements into your project:

```bash
# Fetch latest changes
git fetch template

# Review changes
git log --oneline template/main..HEAD

# Merge template updates
git merge template/main

# Resolve any conflicts
# Then commit the merge
```

### 2. Cherry-Pick Specific Changes

For selective updates:

```bash
# View template commits
git log --oneline template/main

# Cherry-pick specific commit
git cherry-pick <commit-hash>
```

### 3. Compare Files

To see differences between your project and template:

```bash
# Compare specific file
git diff HEAD template/main -- CLAUDE.md

# Compare directory
git diff HEAD template/main -- scripts/

# List changed files
git diff --name-only HEAD template/main
```

## Contributing Back to Template

When you've made improvements that would benefit other projects:

### 1. Identify Shareable Changes

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

### 2. Prepare Changes

```bash
# Create a branch from template
git checkout -b template-improvement template/main

# Cherry-pick your improvements
git cherry-pick <your-commits>

# Or manually apply changes
git checkout your-branch -- path/to/improved/file
```

### 3. Submit to Template

1. Fork the template repository on GitHub
2. Push your branch to your fork
3. Create a PR to the template repository
4. Describe the improvements and their benefits

## Handling Conflicts

Common conflict scenarios and resolutions:

### Modified Scripts
- Template updated a script you've customized
- Resolution: Carefully merge, preserving both improvements

### Documentation Changes
- Both template and project updated CLAUDE.md
- Resolution: Usually keep both sets of changes

### Devcontainer Updates
- Template improved devcontainer setup
- Resolution: Generally accept template version, reapply customizations

## Best Practices

1. **Regular Syncs**: Check for template updates monthly
2. **Document Divergence**: Note in project docs why you diverged from template
3. **Contribute General Improvements**: Share non-specific enhancements
4. **Test After Sync**: Run full test suite after merging template changes
5. **Preserve Project Specifics**: Don't overwrite project-specific configurations

## Example: Syncing ps-monitor Improvements

The @scripts/ps-monitor/ps-monitor.py tool is a good example of shareable functionality:

```bash
# After improving ps-monitor in your project
git add scripts/ps-monitor/ps-monitor.py
git commit -m "feat(ps-monitor): add memory usage tracking"

# Share with template
git checkout -b improve-ps-monitor template/main
git cherry-pick <commit-hash>
git push fork improve-ps-monitor
# Create PR to template
```

## Troubleshooting

### "refusing to merge unrelated histories"
```bash
git merge template/main --allow-unrelated-histories
```

### Large conflicts after long divergence
Consider manual file-by-file comparison rather than full merge

### Template remote missing
Add it manually:
```bash
git remote add template https://github.com/JoernStoehler/claude-code-shared-templates.git
```