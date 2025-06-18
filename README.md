# KI in der Mathematik - Seminar Materials

This repository contains materials and infrastructure for the "KI in der Mathematik" (AI in Mathematics) seminar at the University of Augsburg, Summer Semester 2025.

## Overview

This seminar explores the intersection of artificial intelligence and mathematics through two main components:

### 1. Research Component: Mathematical Theory and AI
- Deep dive into 1-3 research papers on AI applications in mathematics
- Collaborative preparation with a teammate
- Creation of presentation slides and accompanying notes
- Development of visual aids (animated knot transformations, graphs, mathematical visualizations)

### 2. Practical Component: AI-Assisted Problem Solving
- Block seminar on using Claude Code and other AI tools
- Benchmark testing on Analysis 1-3 exercise sheets
- Prompt engineering training and experimentation
- Development of personal prompt libraries and benchmarking infrastructure

## Repository Structure

```
seminar-ki-in-der-mathematik/
├── research/              # Research paper analysis and presentation materials
│   ├── papers/           # Paper summaries and notes
│   ├── slides/           # Presentation slides
│   └── media/            # Visualizations and animations
├── practical/            # Practical AI benchmarking component
│   ├── exercises/        # Analysis 1-3 exercise sheets (LaTeX)
│   ├── prompts/          # Personal prompt library
│   ├── benchmarks/       # Benchmarking results and analysis
│   └── tools/            # Helper scripts and utilities
├── notes/                # General notes and reflections
│   ├── ai-overview/      # Overview of modern AI capabilities
│   ├── techniques/       # Prompt engineering techniques
│   └── reflections/      # Post-seminar reflections
└── src/                  # Python source code
    └── seminar/          # Main package for tools and utilities
```

## Setup

This project uses modern Python tooling with development containers for consistent environments.

### Quick Start (GitHub Codespaces)
1. Click "Code" → "Create codespace on main"
2. Wait for the environment to initialize
3. All dependencies will be automatically installed

### Local Development
1. Install VS Code with Dev Containers extension
2. Clone the repository
3. Open in VS Code and select "Reopen in Container"
4. Run `make install` to set up dependencies

## Key Technologies

- **Presentation**: Manim for mathematical animations, Jupyter for interactive demos
- **AI Integration**: Claude Code, OpenAI API, Anthropic API
- **Data Analysis**: Polars/Pandas for benchmark analysis
- **Documentation**: Jupyter notebooks, Markdown, LaTeX

## Development Workflow

See the [development documentation](docs/claude/development/00-principles.md) for detailed guidelines on:
- Code style and architecture
- Testing practices
- Documentation standards
- Git workflow

## Contact

Jörn Stöhler - MSc Mathematics Student, University of Augsburg

## License

This is an academic project. Materials are shared for educational purposes.