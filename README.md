# Claude Code Project Template

This template provides a complete development environment optimized for Claude Code, with pre-configured DevOps infrastructure, development tools, and best practices.

## Features

- 🐳 **Dual DevContainer Setup**: Optimized for both local development and GitHub Codespaces
- 🤖 **Claude Code Integration**: Pre-configured with Claude Code CLI and documentation
- 🐍 **Modern Python Tooling**: uv for dependency management, ruff for linting, pyright for type checking
- 🧪 **Testing Infrastructure**: pytest with coverage reporting
- 🔄 **CI/CD Pipeline**: GitHub Actions workflow for automated testing
- 📝 **Comprehensive Documentation**: Structured docs for Claude Code workflows
- 🔧 **Developer Tools**: Pre-installed utilities (ripgrep, fd, jq, gh CLI)
- 📊 **Optional Telemetry**: Honeycomb integration for monitoring (if configured)

## Quick Start

### Using GitHub Template

1. Click "Use this template" on GitHub
2. Create your new repository
3. Open in GitHub Codespaces or clone locally

### Local Development

```bash
# Clone your repository
git clone https://github.com/YourUsername/your-project-name.git
cd your-project-name

# Open in VS Code with DevContainers
code .
# Then: Cmd/Ctrl+Shift+P → "Dev Containers: Reopen in Container"
```

### GitHub Codespaces

Simply open the repository in GitHub Codespaces - everything is pre-configured!

## Project Structure

```
.
├── .devcontainer/          # DevContainer configurations
│   ├── local/             # Local development profile
│   ├── codespaces/        # GitHub Codespaces profile
│   └── postCreateCommand/ # Setup scripts
├── .github/
│   └── workflows/         # CI/CD pipelines
├── docs/
│   └── claude/           # Claude Code documentation
│       ├── development/  # Development principles
│       ├── environment/  # Environment setup
│       ├── style/       # Coding standards
│       └── workflows/   # Workflow guides
├── scripts/
│   └── ps-monitor/      # Process monitoring utility
├── src/
│   └── myproject/       # Your project code (rename this)
├── tests/               # Test suite
├── CLAUDE.md           # Claude Code entry point
├── Makefile            # Common commands
└── pyproject.toml      # Project configuration
```

## Configuration

### 1. Update Project Metadata

Edit `pyproject.toml`:
- Change `name` from "your-project-name"
- Update `description` and `authors`
- Rename `src/myproject` to your package name
- Update the package reference in `[tool.hatch.build.targets.wheel]`

### 2. Environment Variables

Copy `.env.example` to `.env` for local development:

```bash
cp .env.example .env
```

Edit `.env` with your values:
- `PROJECT_NAME`: Your project name
- `HONEYCOMB_API_KEY`: (Optional) For telemetry
- Add any project-specific variables

### 3. Update Source Directory

```bash
# Rename the source directory
mv src/myproject src/yourpackage

# Update imports in tests
# Update references in pyproject.toml
```

## Development Workflow

### Common Commands

```bash
# Install dependencies
make install

# Run tests
make test

# Lint code
make lint

# Type checking
make typecheck

# Start development server (customize in Makefile)
make dev
```

### Git Workflow

This template is configured for conventional commits:

```bash
# Feature branch
git checkout -b feat/new-feature

# Conventional commit
git commit -m "feat: add new functionality"

# Create PR
gh pr create
```

### Working with Claude Code

The `CLAUDE.md` file is automatically loaded when Claude Code starts. It contains:
- Essential documentation links
- Common commands
- Project-specific context

## Customization Guide

### Adding Dependencies

Edit `pyproject.toml`:

```toml
dependencies = [
    "pydantic>=2.0.0",
    "fastapi>=0.104.0",  # Add your dependencies
    "numpy>=1.24.0",
]
```

Then run:
```bash
uv sync
```

### Modifying DevContainer

The DevContainer setup uses numbered scripts in `.devcontainer/postCreateCommand/`:
- `01-*.sh`: Environment setup
- `04-*.sh`: Tool installation
- `10-*.sh`: Project dependencies

Add new scripts following the numbering pattern.

### CI/CD Pipeline

The GitHub Actions workflow (`.github/workflows/ci.yml`) runs:
- Linting (ruff)
- Type checking (pyright)
- Tests with coverage
- On Python 3.11 and 3.12

## Template Synchronization

This template can receive updates from the upstream template repository:

```bash
# Pull latest template improvements
git fetch template
git merge template/main

# Cherry-pick specific improvements
git cherry-pick <commit-hash>
```

## Documentation

- **Claude Code Workflows**: See `docs/claude/workflows/`
- **Development Principles**: See `docs/claude/development/`
- **Coding Standards**: See `docs/claude/style/`

## Contributing

When contributing improvements that could benefit other projects:
1. Consider if the change is generally useful
2. Submit PRs to the template repository
3. Keep project-specific code separate

## License

This template is provided as-is. Add your own license file for your project.

---

Built with ❤️ for Claude Code development