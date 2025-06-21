# Template Sync Troubleshooting Guide

## Quick Diagnosis

**Error: "There isn't anything to compare. main and feat/template-sync are entirely different commit histories."**

**Cause**: You tried to push changes from your project directly to the template repository. These are unrelated git repositories with no shared history.

**Solution**: Use the file-copy approach with worktrees detailed below.

## The Fundamental Rule

🚫 **You CANNOT use these git commands between template and project repos:**
- `git merge template/main`
- `git cherry-pick <commit-from-project>`
- `git rebase template/main`
- `git push template <branch>` (from your project)

✅ **You MUST use these approaches instead:**
- Copy files manually between repositories
- Use worktrees in the template clone
- Create new commits in template repository

## Correct Workflow - Step by Step

### 1. One-Time Setup

```bash
# Clone template repository once
cd /workspaces
git clone $CLAUDE_TEMPLATE_REPO_URL
```

### 2. Create Worktree in Template

```bash
# Navigate to template clone
cd /workspaces/claude-code-shared-templates

# Create worktree for your changes
git worktree add /workspaces/feat-add-improvements -b feat/add-improvements
cd /workspaces/feat-add-improvements
```

### 3. Copy Files from Project

```bash
# Copy entire directories
cp -r /workspaces/your-project-name/.devcontainer .
cp -r /workspaces/your-project-name/docs/claude ./docs/

# Copy individual files
cp /workspaces/your-project-name/CLAUDE.md .
cp /workspaces/your-project-name/.env.example .
```

### 4. Generalize the Copied Files

```bash
# Replace project-specific strings
find . -type f -exec sed -i 's/your-project-name/your-project-name/g' {} \;

# Review what changed
git diff
```

### 5. Commit and Push

```bash
# Stage and commit
git add -A
git commit -m "feat: add improvements from seminar project"

# Push to template repository
git push -u origin feat/add-improvements

# Create PR
gh pr create
```

### 6. Clean Up

```bash
# Remove worktree after PR is merged
cd /workspaces/claude-code-shared-templates
git worktree remove /workspaces/feat-add-improvements
```

## Common Mistakes and Fixes

### Mistake 1: Working in Project Directory

❌ **Wrong**:
```bash
cd /workspaces/your-project-name
git push template my-branch  # This will fail!
```

✅ **Right**:
```bash
cd /workspaces/feat-add-improvements  # Template worktree
git push origin my-branch
```

### Mistake 2: Trying to Merge Histories

❌ **Wrong**:
```bash
git fetch template
git merge template/main  # Will fail with "unrelated histories"
```

✅ **Right**:
```bash
# Update template clone
cd /workspaces/claude-code-shared-templates
git pull origin main

# Copy files manually
cp path/to/file /workspaces/your-project-name/
```

### Mistake 3: Forgetting to Generalize

❌ **Wrong**:
```bash
# Copying project-specific content directly
cp /workspaces/your-project-name/README.md .
git add README.md
git commit -m "add readme"  # Still has project-specific content!
```

✅ **Right**:
```bash
cp /workspaces/your-project-name/README.md .
# Edit to remove project specifics or create generic version
sed -i 's/your-project-name/your-project-name/g' README.md
# Review and edit further as needed
git add README.md
git commit -m "add generic readme template"
```

## Emergency Recovery

If you've made a mess:

```bash
# 1. Abandon any attempts in your project
cd /workspaces/your-project-name
git checkout main
git branch -D broken-template-branch

# 2. Clean up template worktrees
cd /workspaces/claude-code-shared-templates
git worktree list  # See what's there
git worktree remove /workspaces/broken-worktree

# 3. Start fresh with new worktree
git worktree add /workspaces/feat-fresh-start -b feat/fresh-start
```

## Mental Model

Think of it like this:

1. **Your Project** = House A
2. **Template Repo** = House B
3. **Git History** = Family Tree

- House A and House B have completely different family trees
- You can't merge family trees
- You CAN copy furniture (files) from House A to House B
- You must physically go to House B (work in template clone) to arrange furniture there

## Visual Workflow

```
/workspaces/
├── your-project-name/        # Your project
│   └── [your project files]
├── claude-code-shared-templates/         # Template clone (one-time)
│   └── .git/                            # Shared git directory
└── feat-add-improvements/               # Template worktree
    └── [working on template changes]
```

## One-Line Reminders

- **Template sync = Copy files, not git history**
- **One clone, many worktrees** - Clone template once, use worktrees
- **Work in template worktree** - Never push from project
- **Generalize everything** - Remove project-specific content
- **gh pr create handles forking** - No need for fork remotes

## Quick Diagnostic Checklist

When something goes wrong, check:

1. **Where am I?** - `pwd` should show template worktree path
2. **What repo am I in?** - `git remote -v` should show template URL
3. **Did I generalize?** - `grep -r "seminar-ki" .` should return nothing
4. **Is this a worktree?** - `git worktree list` should show your location

## Common Error Messages Explained

### "fatal: refusing to merge unrelated histories"
**Meaning**: Git can't merge because repos have no common commits
**Fix**: Don't merge, copy files instead

### "error: src refspec template/main does not match any"
**Meaning**: You're trying to reference a remote that doesn't exist
**Fix**: Work in the template clone, not your project

### "fatal: not a git repository"
**Meaning**: You're not in a git directory
**Fix**: Make sure you're in the template worktree

### "nothing to commit, working tree clean"
**Meaning**: You haven't copied/modified any files yet
**Fix**: Copy files from your project first

## Advanced Tips

### Batch Processing
```bash
# Copy and generalize multiple files at once
cd /workspaces/feat-batch-update
for file in $(find /workspaces/your-project-name/docs -name "*.md"); do
  dest=$(echo $file | sed 's|.*your-project-name/||')
  mkdir -p $(dirname $dest)
  cp $file $dest
  sed -i 's/your-project-name/your-project-name/g' $dest
done
```

### Verification Before Push
```bash
# Check for project-specific strings
grep -r "seminar" . --exclude-dir=.git

# List all changes
git status -s

# Review actual diff
git diff --staged
```

Remember: When in doubt, you're probably trying to do git operations between unrelated repos. Stop and copy files instead!