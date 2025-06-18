# RFC 003: AI Benchmarking Framework

## Status
DRAFT - Quick sketch for evaluation

## Summary
Design for benchmarking framework to evaluate AI performance on Analysis 1-3 exercises.

## Core Architecture

### Simple Implementation (Start here)

```python
# src/seminar/benchmarking/runner.py
from dataclasses import dataclass
from typing import List, Dict, Any
import asyncio
from anthropic import Anthropic
from openai import OpenAI

@dataclass
class Exercise:
    id: str
    course: str  # "analysis1", "analysis2", "analysis3"
    topic: str
    problem: str
    solution: str
    difficulty: int  # 1-5

@dataclass
class BenchmarkResult:
    exercise_id: str
    model: str
    prompt_template: str
    response: str
    correct: bool
    reasoning: str
    tokens_used: int
    time_ms: float

class Benchmarker:
    def __init__(self):
        self.anthropic = Anthropic()
        self.openai = OpenAI()
        
    async def run_exercise(
        self, 
        exercise: Exercise, 
        model: str, 
        prompt_template: str
    ) -> BenchmarkResult:
        # Implementation here
        pass
```

### Prompt Management

```yaml
# practical/prompts/templates.yaml
templates:
  direct:
    name: "Direct Question"
    template: |
      Solve the following exercise from {course}:
      {problem}
      
  chain_of_thought:
    name: "Chain of Thought"
    template: |
      I need help with this {course} exercise.
      
      Problem: {problem}
      
      Please think step-by-step and show all work.
      
  few_shot:
    name: "Few-Shot Learning"
    template: |
      Here are some similar solved examples:
      {examples}
      
      Now solve: {problem}
```

### Data Storage

```python
# Using Polars for efficient analysis
import polars as pl

# Results stored as Parquet for efficiency
results_df = pl.DataFrame({
    "exercise_id": [...],
    "model": [...],
    "correct": [...],
    "tokens": [...],
    "time_ms": [...],
    "timestamp": [...],
})

results_df.write_parquet("benchmarks/results/run_001.parquet")
```

## Features to Implement

### Phase 1 (MVP)
- [ ] Exercise loader from LaTeX files
- [ ] Basic prompt templates (3-5 variants)
- [ ] Claude and GPT-4 integration
- [ ] Simple correctness evaluation
- [ ] Results export to CSV/Parquet

### Phase 2 (Enhanced)
- [ ] Automatic grading with rubrics
- [ ] Token usage tracking
- [ ] Cost calculation
- [ ] Visualization dashboard (Plotly)
- [ ] Prompt evolution tracking

### Phase 3 (Advanced)
- [ ] Multi-turn conversation support
- [ ] Image/diagram handling
- [ ] Collaborative solving simulation
- [ ] Statistical analysis of results

## Quick Start Implementation

```python
# practical/benchmarks/quick_test.py
import asyncio
from seminar.benchmarking import Benchmarker, Exercise

# Load exercise
exercise = Exercise(
    id="analysis1_ex1",
    course="Analysis 1",
    topic="Limits",
    problem="Calculate lim(x→0) sin(x)/x",
    solution="1",
    difficulty=2
)

# Run benchmark
benchmarker = Benchmarker()
results = asyncio.run(benchmarker.run_exercise(
    exercise,
    model="claude-3-opus",
    prompt_template="chain_of_thought"
))

print(f"Correct: {results.correct}")
print(f"Tokens: {results.tokens_used}")
```

## Advantages of This Approach

1. **Practical**: Directly addresses seminar goals
2. **Extensible**: Easy to add new models/prompts
3. **Scientific**: Produces analyzable data
4. **Reusable**: Framework useful beyond seminar

## Notes

- Start simple, expand based on needs
- Consider using Langchain for model abstraction
- Export results in multiple formats for analysis
- Keep raw responses for post-hoc analysis