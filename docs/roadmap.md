# Project Roadmap

## Current Status

### ✅ Milestone 1: Template Project Setup (Completed)

This template project has been set up with a complete DevOps infrastructure and example files to demonstrate the setup.

#### Completed Features:

**DevOps Infrastructure:**
- ✅ Dual devcontainer setup (local and codespaces profiles)
- ✅ Git workflows with conventional commits (documented in CLAUDE.md)
- ✅ Environment variable management (.env.example for both local and codespaces)
- ✅ Basic Git configuration (.gitignore)
- ✅ Python project configuration (pyproject.toml)
- ✅ CI/CD pipeline configuration (GitHub Actions)
- ✅ Development tooling configuration (uv, ruff, pyright, pytest)
- ✅ Pre-commit hooks configuration
- ✅ Makefile with standard commands
- ✅ Git LFS configuration (.gitattributes)
- ✅ Environment naming consistency (.env for local development)

**Project Structure:**
- Python project using modern tools (uv for dependency management)
- Type checking with pyright
- Linting with ruff
- Testing framework with pytest
- Example module structure demonstrating best practices

**Documentation:**
- CLAUDE.md with comprehensive development guidelines
- Project principles and workflows documented
- Claude Code specific instructions and optimizations

**Example Implementation:**
- Basic example module with pure functions
- Pydantic models for data validation
- Test-driven development examples
- Type annotations with jaxtyping

### ✅ Milestone 2: Devcontainer Features and Template Synchronization (Completed)

Successfully transformed the template repository into a composable system with:

#### Completed Features:

**Devcontainer Features:**
- ✅ Created three modular devcontainer features in `src/`:
  - `claude-code-environment` - Runtime environment and telemetry configuration
  - `claude-code-tools` - Development tools and Claude CLI installation
  - `claude-template-remote` - Git remote setup for template synchronization
- ✅ Added GitHub Actions workflows for testing and publishing features
- ✅ Implemented comprehensive test suites for each feature

**Documentation Restructure:**
- ✅ Split monolithic CLAUDE.md into modular documentation:
  - Environment setup guides
  - Development principles and practices
  - Workflow documentation
  - Coding and documentation standards
- ✅ Created clear navigation structure with cross-references
- ✅ Simplified main CLAUDE.md as an entry point

**Scripts Organization:**
- ✅ Reorganized scripts into logical subdirectories
- ✅ Moved ps-monitor to dedicated subdirectory with README
- ✅ Prepared structure for future MCP server implementations

**Template Configuration:**
- ✅ Updated devcontainer.json files to use new features
- ✅ Cleaned up redundant postCreateCommand scripts
- ✅ Maintained backward compatibility

## Future Milestones

### Milestone 3: Core Application Development
- [ ] Implement main application logic
- [ ] Add FastAPI endpoints
- [ ] Integrate JAX/NumPyro for probabilistic programming
- [ ] Add data processing with Polars

### Milestone 3: Testing and Quality Assurance
- [ ] Achieve ≥80% test coverage
- [ ] Add integration tests
- [ ] Performance benchmarks
- [ ] Documentation generation

### Milestone 4: Production Readiness
- [ ] Production deployment configuration
- [ ] Monitoring and logging
- [ ] API documentation
- [ ] User guides

## Notes

This template serves as a foundation for scientific computing projects using modern Python tooling and best practices. The setup emphasizes:
- Low cognitive load through clear structure and naming
- Fast exploration and onboarding with comprehensive CLAUDE.md
- Robust development workflow with automated checks
- Type safety and data validation throughout