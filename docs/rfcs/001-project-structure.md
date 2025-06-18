# RFC 001: Project Structure Options

## Status
DRAFT - Quick sketch for evaluation

## Summary
Evaluating project structure options for the KI in der Mathematik seminar repository.

## Options

### Option 1: Python Monorepo (Recommended)

```
seminar-ki-in-der-mathematik/
├── research/
│   ├── papers/
│   │   ├── paper1_notes.md
│   │   └── paper2_summary.ipynb
│   ├── slides/
│   │   ├── presentation.ipynb    # Using RISE or similar
│   │   └── assets/
│   └── media/
│       ├── knot_animations.py    # Manim scripts
│       └── generated/
├── practical/
│   ├── exercises/
│   │   ├── analysis1/
│   │   ├── analysis2/
│   │   └── analysis3/
│   ├── prompts/
│   │   └── prompt_library.yaml
│   ├── benchmarks/
│   │   ├── run_benchmark.py
│   │   └── results/
│   └── tools/
│       └── ai_wrapper.py
├── notes/
│   ├── ai-overview.md
│   └── techniques/
├── src/
│   └── seminar/
│       ├── __init__.py
│       ├── visualization/      # Manim helpers
│       ├── benchmarking/       # Benchmark framework
│       └── utils/
└── tests/
```

**Pros:**
- Single cohesive project with shared utilities
- Easy dependency management with uv
- Consistent tooling across all components
- Already configured in pyproject.toml

**Cons:**
- Might become large if many animations/visualizations

### Option 2: Multi-Component Structure

```
seminar-ki-in-der-mathematik/
├── presentation/              # Separate presentation project
│   ├── slides/               # Using Quarto or reveal.js
│   ├── manim_scenes/
│   └── package.json          # If using JS-based tools
├── benchmarking/             # Separate Python project
│   ├── src/
│   ├── tests/
│   └── pyproject.toml
├── exercises/                # LaTeX project
│   ├── analysis1/
│   └── Makefile
└── shared/                   # Shared documentation
    └── notes/
```

**Pros:**
- Clear separation of concerns
- Can use optimal tech stack for each component
- Easier to share individual components

**Cons:**
- More complex setup and maintenance
- Harder to share code between components
- Multiple dependency management systems

### Option 3: Notebook-Centric Approach

```
seminar-ki-in-der-mathematik/
├── notebooks/
│   ├── 01_paper_analysis/
│   ├── 02_presentation/        # RISE presentations
│   ├── 03_benchmarks/
│   └── 04_exercises/
├── lib/                        # Shared Python code
│   └── seminar/
├── data/
│   ├── exercises/
│   └── benchmark_results/
└── outputs/
    ├── slides_export/
    └── animations/
```

**Pros:**
- Natural for academic work
- Easy to iterate and experiment
- Good for mixing code, math, and visualizations

**Cons:**
- Can become messy without discipline
- Version control challenges with notebooks
- Less suitable for complex software

## Recommendation

**Go with Option 1 (Python Monorepo)** because:
1. Template already configured for this
2. Unified tooling and dependencies
3. Easy to share utilities between research and practical components
4. Natural evolution path - can always split later if needed
5. Single source of truth for all seminar materials

## Implementation Notes

- Keep Jupyter notebooks for exploration and presentation
- Use Manim for mathematical animations (already in dependencies)
- Consider nbconvert or Quarto for final slide generation
- Structure allows both notebook and script workflows