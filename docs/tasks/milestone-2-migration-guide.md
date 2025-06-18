# Migration Guide: Adopting Devcontainer Features

This guide helps existing projects derived from template-universal adopt the new devcontainer features system.

## Overview

The template has been updated to use modular devcontainer features instead of monolithic setup scripts. This provides:
- Easier maintenance and updates
- Selective feature adoption
- Better version control
- Cleaner devcontainer configuration

## Migration Steps

### 1. Update Your Git Remotes

First, ensure you have the template repository as a remote:

```bash
# Check existing remotes
git remote -v

# Add template remote if missing
git remote add template https://github.com/JoernStoehler/template-universal.git

# Fetch latest template changes
git fetch template
```

### 2. Review Changes

Compare your project with the updated template:

```bash
# See all changed files
git diff --name-only HEAD template/main

# Review specific changes
git diff HEAD template/main -- .devcontainer/
git diff HEAD template/main -- CLAUDE.md
```

### 3. Adopt Devcontainer Features

#### Option A: Full Migration (Recommended)

Merge all template changes:

```bash
# Create a migration branch
git checkout -b adopt-devcontainer-features

# Merge template changes
git merge template/main

# Resolve conflicts if any
# Pay special attention to:
# - .devcontainer/local/devcontainer.json
# - .devcontainer/codespaces/devcontainer.json
# - Any customized postCreateCommand scripts
```

#### Option B: Selective Adoption

Cherry-pick specific features:

```bash
# Just adopt the devcontainer features
git cherry-pick <commit-hash-for-devcontainer-updates>

# Or manually update devcontainer.json files
```

### 4. Update Devcontainer Configuration

Add features to your devcontainer.json files:

```json
"features": {
  "ghcr.io/joernstoehler/template-universal/claude-code:1": {},
  "ghcr.io/joernstoehler/template-universal/claude-code-telemetry:1": {},
  "ghcr.io/joernstoehler/template-universal/claude-code-common-cli-tools:1": {},
  "ghcr.io/joernstoehler/template-universal/claude-code-shared-templates-git-remote:1": {
    "templateUrl": "https://github.com/JoernStoehler/template-universal.git"
  }
}
```

Note: Once features are published to ghcr.io, use the registry path instead of local paths.

### 5. Clean Up Legacy Scripts

After adopting features, you can simplify postCreateCommand scripts:

- `20-install-claude-cli.sh` - Can be removed or simplified
- `25-install-dev-cli-tools.sh` - Can be removed or simplified
- Keep project-specific setup scripts

### 6. Adopt New Documentation Structure

The modular documentation provides better organization:

1. Review new structure in `docs/claude/`
2. Migrate any custom documentation to appropriate locations
3. Update your CLAUDE.md to match the new concise format

### 7. Update Scripts Organization

If you have custom scripts:

```bash
# Create subdirectories
mkdir -p scripts/your-tool-name

# Move scripts to subdirectories
mv scripts/your-tool.py scripts/your-tool-name/

# Add README.md for each tool
```

### 8. Test the Migration

1. **Rebuild your devcontainer**:
   - VS Code: Cmd/Ctrl+Shift+P → "Rebuild Container"
   - Or: `devcontainer rebuild`

2. **Verify features are working**:
   ```bash
   # Check Claude CLI
   claude --version
   
   # Check dev tools
   rg --version
   fd --version
   
   # Check git remotes
   git remote -v
   ```

3. **Test your workflows**:
   - Run your test suite
   - Try common development tasks
   - Verify environment variables are set

## Troubleshooting

### Feature Not Found

If you get "feature not found" errors:
- Ensure you're using the correct feature paths
- For local development before publishing, use relative paths: `../../src/feature-name`
- After publishing, use registry paths: `ghcr.io/joernstoehler/template-universal/feature-name:1`

### Environment Variables Missing

The features set different environment variables:
- `claude-code`: Sets CLAUDE_CONFIG_DIR
- `claude-code-telemetry`: Sets telemetry variables (OTEL_*)
- For project-specific variables:
- Keep your `.env` file for local development
- Keep your `.env.example` for Codespaces
- The `reload-env` function still works for project variables

### Conflicts During Merge

Common conflict areas:
- **devcontainer.json**: Usually keep both changes (features + your customizations)
- **CLAUDE.md**: Adopt new structure but preserve project-specific sections
- **postCreateCommand scripts**: Can usually accept template version if using features

### Tools Not Available

If tools like `rg` or `fd` are missing:
- Ensure claude-code-tools feature is included
- Check feature logs during container build
- Manually install if needed: `sudo apt-get install ripgrep fd-find`

## Benefits After Migration

1. **Easier Updates**: Pull template improvements with less conflicts
2. **Modular Setup**: Enable/disable features as needed
3. **Faster Container Builds**: Features are cached
4. **Better Documentation**: Organized, searchable documentation
5. **Template Sync**: Easy bidirectional sync of improvements

## Next Steps

After migration:
1. Review the new workflow documentation
2. Explore template synchronization workflows
3. Consider contributing improvements back to the template
4. Update your project's README with any migration notes