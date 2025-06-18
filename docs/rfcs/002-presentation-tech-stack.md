# RFC 002: Presentation Technology Stack

## Status
DECIDED

## Decision
**Quarto** for all presentations.

## Implementation

Write slides in Quarto markdown:
```markdown
---
title: KI in der Mathematik
format:
  revealjs:
    slide-number: true
    theme: default
---

# Knot Invariants

## Alexander Polynomial

$$\Delta_K(t) = \det(tV - V^T)$$

::: {.notes}
Speaker notes here
:::

## Code Example

```{python}
def compute_invariant(knot):
    return det(t * V - V.T)
```

![Knot diagram](media/knot.png)
```

Build commands:
```bash
quarto render slides.qmd --to revealjs  # HTML slides
quarto render slides.qmd --to beamer   # PDF backup
```

## Rationale
- Best balance of features and simplicity
- Excellent math support via LaTeX
- Speaker notes built-in
- Multiple output formats
- Active development