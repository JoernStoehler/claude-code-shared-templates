# Repository Migration Handoff Document

**Date**: 2024-06-18  
**Status**: Features repository complete, templates repository pending

## Context

We're migrating from a single monolithic repository (`template-universal`) to two specialized repositories:

1. **[claude-code-devcontainer-features](https://github.com/JoernStoehler/claude-code-devcontainer-features)** - ✅ DONE
   - Contains reusable devcontainer features
   - Will be published to GitHub Container Registry
   
2. **[claude-code-shared-templates](https://github.com/JoernStoehler/claude-code-shared-templates)** - 🚧 TODO  
   - Will contain the project template
   - Shared resources like CLAUDE.md, docs, scripts

## What Has Been Done

### 1. Features Repository Setup ✅

The `claude-code-devcontainer-features` repository now contains:

```
claude-code-devcontainer-features/
├── src/
│   ├── claude-code/                              # CLI installation
│   ├── claude-code-telemetry/                   # OpenTelemetry setup
│   ├── claude-code-common-cli-tools/            # Dev tools
│   └── claude-code-shared-templates-git-remote/ # Git remote config
├── test/                                         # Test scripts
├── .github/workflows/                            # CI/CD
│   ├── release-features.yaml                     # Publishing workflow
│   └── test-features.yaml                       # Testing workflow
├── README.md                                     # Comprehensive docs
├── LICENSE                                       # MIT
└── .gitignore
```

**Key Updates Made:**
- Updated all documentation URLs to point to new repository
- Changed default template URL in git-remote feature to `claude-code-shared-templates`
- Added comprehensive README with usage examples

### 2. Migration Work Directory 📁

All migration work is in:
```
/workspaces/template-universal/migration/
├── claude-code-devcontainer-features/  # Ready, pushed to GitHub
└── claude-code-shared-templates/       # Empty, needs setup
```

## What Needs to Be Done

### 1. Publish Devcontainer Features 🚀

```bash
# Go to https://github.com/JoernStoehler/claude-code-devcontainer-features/actions
# Run the "Release Dev Container Features" workflow
# This will publish to ghcr.io/joernstoehler/claude-code-devcontainer-features/
```

### 2. Set Up Shared Templates Repository 📝

Copy everything EXCEPT features from template-universal:

```bash
cd /workspaces/template-universal/migration/claude-code-shared-templates/

# Copy all non-feature files
cp -r ../../.devcontainer .
cp -r ../../.vscode .
cp -r ../../docs .
cp -r ../../scripts .
cp -r ../../tests .        # Python tests (not feature tests)
cp ../../CLAUDE.md .
cp ../../pyproject.toml .
cp ../../Makefile .
cp ../../.env.example .
cp ../../.gitignore .
cp ../../.gitattributes .
cp ../../requirements*.txt . 2>/dev/null || true

# Create src directory for Python code
mkdir -p src
# Copy any Python source code if it exists
```

### 3. Update All References 🔄

In the shared-templates repository, update:

#### In `.devcontainer/local/devcontainer.json` and `.devcontainer/codespaces/devcontainer.json`:
```json
// Change from:
"../../src/claude-code": {}

// To (after features are published):
"ghcr.io/joernstoehler/claude-code-devcontainer-features/claude-code:1": {}
```

#### In documentation:
- Replace references to `template-universal` with `claude-code-shared-templates`
- Update any links to feature documentation

#### In the git-remote feature default:
Already done - it points to `claude-code-shared-templates`

### 4. Test Everything 🧪

1. **Test Features in isolation:**
   ```bash
   cd /path/to/claude-code-devcontainer-features
   devcontainer features test
   ```

2. **Test template with published features:**
   - Create new repo from claude-code-shared-templates
   - Open in devcontainer
   - Verify all features work

3. **Test template synchronization:**
   ```bash
   git remote -v  # Should show 'template' remote
   git fetch template
   ```

### 5. Update Documentation 📚

Create/update in shared-templates repo:
- README.md explaining how to use the template
- Migration guide for existing projects
- Update roadmap/changelog

### 6. Archive or Update template-universal 🗄️

Options:
1. Archive the repository with a note pointing to new repos
2. Keep it but update README to redirect users
3. Convert it to a simple example project using the new structure

## Important Notes

### URLs to Remember

- Features: `ghcr.io/joernstoehler/claude-code-devcontainer-features/FEATURE_NAME:VERSION`
- Template: `https://github.com/JoernStoehler/claude-code-shared-templates`
- Old repo: `https://github.com/JoernStoehler/template-universal` (to be deprecated)

### Authentication for Pushing

If you need to push to the shared-templates repo:
1. Create a Personal Access Token at https://github.com/settings/tokens/new
2. Select `repo` scope
3. Use: `git push https://JoernStoehler:TOKEN@github.com/JoernStoehler/claude-code-shared-templates.git main`

### Testing Checklist

- [ ] Features publish successfully to ghcr.io
- [ ] New devcontainer builds with published features
- [ ] Claude CLI works
- [ ] All dev tools installed
- [ ] Git remote configured correctly
- [ ] Template sync workflow functions
- [ ] Documentation is clear and accurate

## Questions for Decisions

1. **Version Strategy**: Start all features at 1.0.0 or 0.1.0?
2. **Template Name**: Keep "template-universal" name or rename in shared-templates?
3. **Migration Path**: How to handle existing users of template-universal?

## Contact

**Project Owner**: Jörn Stöhler
- Direct communication preferred
- Review PRs via `gh pr create`

## Summary

The hardest part (extracting and setting up features) is done. The remaining work is mostly copying files and updating references. The new structure will be much cleaner and more maintainable.