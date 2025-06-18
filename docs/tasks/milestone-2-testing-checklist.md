# Milestone 2 Testing Checklist

This checklist ensures all devcontainer features and template changes work correctly.

## Pre-Testing Setup

- [ ] Ensure all changes are committed
- [ ] Features are using local paths (../../src/) until published
- [ ] GitHub Actions workflows are in place

## Local Devcontainer Testing

### 1. Fresh Container Build
- [ ] Delete existing container and volumes
- [ ] Rebuild devcontainer from VS Code
- [ ] Monitor build output for feature installation

### 2. Feature Verification

#### Claude Code Environment Feature
- [ ] Check environment variables:
  ```bash
  echo $CLAUDE_CONFIG_DIR
  echo $CLAUDE_CODE_ENABLE_TELEMETRY
  echo $OTEL_SERVICE_NAME
  echo $OTEL_EXPORTER_OTLP_ENDPOINT
  ```
- [ ] Verify config directory exists
- [ ] Confirm telemetry settings match configuration

#### Claude Code Tools Feature
- [ ] Verify Claude CLI: `claude --version`
- [ ] Check dev tools installation:
  ```bash
  command -v rg && rg --version
  command -v fdfind && fdfind --version
  command -v batcat && batcat --version
  command -v jq && jq --version
  command -v tree && tree --version
  ```
- [ ] Test git configuration:
  ```bash
  git config --get diff.algorithm
  git config --get merge.conflictstyle
  ```
- [ ] Verify aliases work: `fd`, `bat`

#### Claude Template Remote Feature
- [ ] Check git remotes: `git remote -v`
- [ ] Verify template remote exists
- [ ] Test fetching: `git fetch template`

### 3. Script Functionality
- [ ] Run ps-monitor: `uv run scripts/ps-monitor/ps-monitor.py`
- [ ] Verify script finds Claude processes
- [ ] Check clean exit with Ctrl+C

### 4. Documentation Access
- [ ] Start new Claude session
- [ ] Verify CLAUDE.md loads automatically
- [ ] Test navigation to modular docs
- [ ] Confirm all @references work

### 5. Environment Loading
- [ ] Test `reload-env` function
- [ ] Create test .env file
- [ ] Verify project-specific vars load
- [ ] Check Honeycomb API key handling

## GitHub Codespaces Testing

### 1. Create New Codespace
- [ ] Create fresh Codespace from main branch
- [ ] Monitor creation logs
- [ ] Verify no errors during setup

### 2. Feature Verification (Codespaces)
- [ ] Repeat all feature checks from local testing
- [ ] Verify CODESPACES env var is set
- [ ] Check secrets are properly loaded
- [ ] Confirm .env.example is used

### 3. Codespaces-Specific
- [ ] Test repository permissions
- [ ] Verify claude-universal-docs access
- [ ] Check OAuth token persistence

## Integration Testing

### 1. Existing Project Update
- [ ] Clone existing project using old template
- [ ] Add template remote
- [ ] Follow migration guide
- [ ] Verify successful migration

### 2. New Project Creation
- [ ] Use template to create new repository
- [ ] Clone and open in devcontainer
- [ ] Verify all features work out-of-box
- [ ] Test template sync workflow

## GitHub Actions Testing

### 1. Feature Tests
- [ ] Push changes to trigger workflows
- [ ] Verify test-features.yaml runs
- [ ] Check all feature tests pass
- [ ] Review test output for issues

### 2. Feature Publishing (when ready)
- [ ] Trigger release workflow
- [ ] Verify features publish to ghcr.io
- [ ] Test using published features

## Performance Testing

- [ ] Measure container build time
- [ ] Compare with previous setup
- [ ] Check for redundant operations
- [ ] Verify feature caching works

## Edge Cases

- [ ] Test with no internet (offline)
- [ ] Test with restricted permissions
- [ ] Test with existing config conflicts
- [ ] Test with non-standard shells

## Known Issues to Verify

- [ ] Local feature paths work correctly
- [ ] No duplicate tool installations
- [ ] Environment vars don't conflict
- [ ] Git operations work in worktrees

## Post-Testing

### Documentation Updates
- [ ] Update any discovered issues
- [ ] Document workarounds if needed
- [ ] Add troubleshooting entries

### Final Verification
- [ ] All todos marked complete
- [ ] Roadmap updated
- [ ] Changelog accurate
- [ ] Migration guide tested

## Sign-off

- [ ] Local devcontainer: Working
- [ ] GitHub Codespaces: Working
- [ ] Feature installation: Verified
- [ ] Documentation: Complete
- [ ] Ready for PR submission

---

**Note**: This testing should be performed by rebuilding containers after all changes are committed. Some tests require creating new Codespaces or fresh local environments.