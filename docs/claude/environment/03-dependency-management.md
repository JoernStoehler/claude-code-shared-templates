# Dependency Management Guide

## Overview

This project uses a modular dependency structure to optimize CI/CD performance and developer flexibility. Dependencies are organized into groups based on their purpose.

## Dependency Groups

### Core Dependencies (Always Installed)
- **pandas**: Data manipulation and analysis
- **numpy**: Numerical computations  
- **pydantic**: Data validation and settings management
- **httpx**: Modern HTTP client
- **tqdm**: Progress bars
- **click**: Command-line interface creation
- **rich**: Rich terminal formatting

### Optional Dependency Groups

#### `animations` - Mathematical Animations
- **manim**: Create mathematical animations (knot theory, transformations)
- **System requirements**: libcairo2-dev, libpango1.0-dev, ffmpeg
- **Install**: `make install-animations`
- **Use case**: Creating visual demonstrations for presentations

#### `slides` - Presentation Tools
- **jupyterlab**: Interactive notebooks and presentations
- **matplotlib**: Static plotting and figures
- **plotly**: Interactive visualizations
- **Note**: Quarto installed separately via system package
- **Install**: `make install-slides`
- **Use case**: Building course materials and slides

#### `ai` - AI/ML Integration
- **openai**: OpenAI API client
- **anthropic**: Anthropic (Claude) API client
- **langchain**: LLM application framework
- **Install**: `make install-ai`
- **Use case**: AI benchmarking and experiments

#### `ci` - CI/CD Minimal Set
- **ruff**: Fast Python linter
- **pyright**: Type checker
- **pytest**: Testing framework
- **pytest-cov**: Coverage reporting
- **Install**: `make install-ci`
- **Use case**: GitHub Actions CI pipeline (minimal deps for speed)

#### `dev` - Full Development
- Everything from `ci` plus:
- **pytest-xdist**: Parallel test execution
- **pre-commit**: Git hook framework
- **Install**: `make install-dev`
- **Use case**: Local development environment

## Installation Commands

```bash
# Core dependencies only (minimal)
make install

# Full development environment (recommended)
make install-dev

# Specific features
make install-animations  # For manim
make install-slides     # For presentations
make install-ai         # For AI experiments

# CI environment (used by GitHub Actions)
make install-ci
```

## Common Scenarios

### New Developer Setup
The devcontainer automatically runs `make install-dev`, giving you everything needed for development.

### Working on Animations
If you see `ModuleNotFoundError: No module named 'manim'`:
```bash
make install-animations
```

### Creating Presentations
If you see `ModuleNotFoundError: No module named 'matplotlib'`:
```bash
make install-slides
```

### CI/CD Pipeline
The CI workflow uses `uv sync --extra ci` to install only what's needed for testing and linting, reducing build time by ~70%.

## System Dependencies

Some packages require system-level libraries:

### For Animations (manim)
```bash
sudo apt-get install -y libcairo2-dev libpango1.0-dev ffmpeg
```
These are automatically installed in the devcontainer.

### For Documentation (Quarto)
Quarto is installed separately in the devcontainer setup. For manual installation:
```bash
# See https://quarto.org/docs/get-started/
```

## Troubleshooting

### Import Errors
If you get import errors, check which dependency group contains the package:
1. Look in `pyproject.toml` under `[project.optional-dependencies]`
2. Install the appropriate group with `make install-<group>`

### CI Failures
CI uses minimal dependencies. If CI fails but local tests pass:
- Check if you're using a dependency not in the `ci` group
- Consider if the dependency should be in core or remain optional

### Performance
- Core dependencies: ~10 seconds to install
- Full dev environment: ~30 seconds to install  
- CI dependencies: ~5 seconds to install
- Animation dependencies: ~20 seconds + system deps