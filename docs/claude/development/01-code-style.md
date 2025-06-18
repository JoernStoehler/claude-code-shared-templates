# Code Style Guidelines

## Type Checking and Linting

### Type Checking
- **Tool**: `pyright` in standard mode
- **Usage**: `uv run pyright .`
- Use type hints for non-obvious input/output types
- Use JaxTyping for documenting data structure shapes

### Linting
- **Tool**: `ruff` with minimal rules
- **Usage**: `uv run ruff check .`
- Only bug-preventing rules enabled
- No automatic formatting (preserves Claude Code's context)
- Apply fixes manually before PR submission

### Pull Request Requirements
- Must pass type checking
- Must pass linting
- Configuration bias: disable non-essential rules

## Code Architecture

### Pure Functions and Immutability
- Prefer pure functions with immutable data structures
- Use Pydantic models for data validation and serialization
- Document raised exceptions in docstrings
- For expected exceptions, use return types like `T | Error`

### Design Principles
- **YAGNI**: Only implement what's necessary for current milestone
- **KISS**: Keep solutions simple and straightforward
- **Locality over DRY**: Repeat short snippets for clarity rather than abstracting

## Documentation Standards

### Docstrings
- Use Google-style docstrings
- Reference mathematical models when applicable
- Map arguments to mathematical symbols
- Note deviations from formal models

### Naming Conventions
- Optimize code symbols for clarity and descriptiveness
- Use standard mathematical notation
- Prefer longer, descriptive names over brevity

## Example

```python
from typing import Union
from pydantic import BaseModel
from jaxtyping import Float, Array

class ComputationError(BaseModel):
    """Error returned when computation fails."""
    message: str
    code: str

def compute_gradient(
    x: Float[Array, "batch dim"], 
    learning_rate: float = 0.01
) -> Union[Float[Array, "batch dim"], ComputationError]:
    """Compute gradient using standard backpropagation.
    
    Implements equation (3.2) from Nielsen (2015):
        ∇C = ∂C/∂w
    
    Args:
        x: Input tensor with shape (batch_size, dimensions)
        learning_rate: α in the paper, controls step size
        
    Returns:
        Gradient tensor or error if computation fails
        
    Raises:
        ValueError: If input dimensions are invalid
    """
    # Implementation here
    pass
```