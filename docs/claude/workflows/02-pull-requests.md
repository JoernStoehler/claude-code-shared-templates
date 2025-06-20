# Pull Request Workflows

## Git Configuration

### Project Setup
- Only Jörn and Claude Code work as developers
- Use GitHub for version control, CI/CD, and Codespaces
- Work in git worktrees at `/workspaces/{branch-name-slug}`

### Commit Standards
Use conventional commits format:
```
type(scope): subject

[optional body]

[optional footer]
```

Types:
- `feat`: New feature
- `fix`: Bug fix
- `docs`: Documentation only
- `style`: Code style (formatting, semicolons, etc)
- `refactor`: Code restructure without behavior change
- `test`: Test additions or corrections
- `chore`: Maintenance tasks

## Creating Pull Requests

### 1. Prepare Changes

```bash
# Ensure you're in the worktree directory
pwd  # Should show /workspaces/{branch-name}

# Review changes
git status
git diff

# Stage specific changes
git add src/feature.py tests/test_feature.py  # Add specific files
# OR for multiple files in a directory:
git add src/new_module/

# Verify what will be committed
git status

# Commit with conventional format
git commit -m "feat(feature-name): implement new functionality"
```

### 2. Push to Remote

```bash
# First push of a new branch
git push -u origin branch-name

# Subsequent pushes
git push
```

### 3. Create PR with gh CLI

```bash
# Basic PR creation
gh pr create --title "feat: add new feature" \
  --body "## Summary
- Implemented X functionality
- Added tests for Y
- Updated documentation

## Testing
- All tests pass
- Manual testing completed"

# With more details
gh pr create --title "fix: resolve data processing issue" \
  --body "## Summary
Fixes the data processing pipeline that was failing on large datasets.

## Changes
- Optimized memory usage in process_data()
- Added chunking for files >1GB
- Improved error handling

## Testing
- Added unit tests for chunking logic
- Tested with 5GB dataset
- Performance: 3x faster on large files

## Breaking Changes
None

## Related Issues
Fixes #123"
```

### 4. Check CI Status

```bash
# View PR checks
gh pr checks

# Watch checks in real-time
gh pr checks --watch

# View workflow runs
gh run list
gh run view <run-id>
```

### 5. Handle CI Failures

```bash
# View failed job logs
gh run view <run-id> --log-failed

# Common fixes:
# - Linting: uv run ruff check . --fix
# - Type checking: uv run pyright .
# - Tests: uv run pytest -xvs
# - Pre-commit: pre-commit run --all-files
```

## PR Best Practices

### Title Guidelines
- Use conventional commit format
- Be specific but concise
- Examples:
  - ✅ `feat(auth): add OAuth2 GitHub provider`
  - ✅ `fix(parser): handle empty input gracefully`
  - ❌ `Update code`
  - ❌ `Fixed bug`

### Careful Staging
- Always review changes before staging:
  ```bash
  git status          # See all changed files
  git diff            # Review actual changes
  git add file1 file2 # Stage specific files only
  ```
- Avoid `git add -A` to prevent accidentally committing:
  - Temporary files or scripts
  - Debug logs or test outputs
  - Personal configuration files
  - Files created during experimentation
- Use `git status` after staging to verify

### Description Template

```markdown
## Summary
[1-3 sentences describing what this PR does]

## Motivation
[Why this change is needed]

## Changes
- [Bullet points of specific changes]
- [Include technical details]

## Testing
- [ ] Unit tests added/updated
- [ ] Integration tests pass
- [ ] Manual testing completed
- [ ] Performance impact assessed

## Screenshots
[If applicable]

## Breaking Changes
[List any breaking changes or "None"]

## Checklist
- [ ] Tests pass
- [ ] Linting passes
- [ ] Type checking passes
- [ ] Documentation updated
- [ ] CHANGELOG.md updated
```

### Review Preparation

Before requesting review:

1. **Self-review your changes**
   ```bash
   # Review your own PR
   gh pr view --web
   ```

2. **Ensure CI passes**
   ```bash
   gh pr checks
   ```

3. **Update documentation**
   - Update relevant .md files
   - Update CHANGELOG.md
   - Update inline code comments

4. **Clean up commits** (if needed)
   ```bash
   # Interactive rebase to clean history
   git rebase -i main
   ```

## Requesting Review

### Formal Review Request

```bash
# After CI passes, comment on PR
gh pr comment --body "@JoernStoehler This PR is ready for review.

## Highlights
- [Key change 1]
- [Key change 2]

## Review Focus
Please pay special attention to:
- [Specific area needing scrutiny]
- [Architectural decision that needs validation]

## Testing
- All tests pass ✅
- CI checks pass ✅
- Manual testing completed ✅"
```

### Quick Reviews

For simple changes:
```bash
gh pr comment --body "@JoernStoehler Simple fix ready for review. CI passing."
```

## Common Issues

### Pre-commit Hook Failures
```bash
# Install/update pre-commit
pre-commit install
pre-commit run --all-files

# If files are modified by hooks
git add -A
git commit --amend --no-edit
git push --force-with-lease
```

### Merge Conflicts
```bash
# Update from main
git fetch origin
git merge origin/main

# Resolve conflicts, then
git add <resolved-files>
git commit
git push
```

### Large PRs
Consider splitting into smaller PRs:
1. Infrastructure/setup PR
2. Core functionality PR  
3. Tests and documentation PR

## After Merge

The PR will be automatically closed after merge. The worktree can be cleaned up by Jörn in the next session.