# Coding Standards

## Language-Specific Standards

### Python

#### Project Structure
```
project/
├── src/
│   └── mypackage/
│       ├── __init__.py
│       ├── core/
│       ├── models/
│       └── utils/
├── tests/
│   ├── conftest.py
│   ├── test_core/
│   └── test_models/
├── scripts/
│   └── utility-name/
│       ├── utility.py
│       └── README.md
├── docs/
├── pyproject.toml
└── Makefile
```

#### Import Organization
```python
# Standard library imports
import os
import sys
from pathlib import Path

# Third-party imports
import numpy as np
import pandas as pd
from pydantic import BaseModel

# Local application imports
from mypackage.core import process_data
from mypackage.models import DataModel
```

#### Type Annotations
Always use type hints for function signatures:
```python
from typing import List, Dict, Optional, Union
from jaxtyping import Float, Array

def process_items(
    items: List[Dict[str, Any]], 
    threshold: float = 0.5
) -> Optional[Float[Array, "batch dim"]]:
    """Process items and return results."""
    pass
```

### Dependencies and Tools

#### Using uv
All Python commands should use `uv run`:
```bash
# Not: python script.py
uv run python script.py

# Not: pytest
uv run pytest

# Not: pip install
uv add package_name
```

#### Makefile Commands
Standard targets for all projects:
```makefile
.PHONY: install test lint typecheck run dev

install:
	uv sync --frozen

test:
	uv run pytest

lint:
	uv run ruff check .

typecheck:
	uv run pyright .
```

## Code Quality Standards

### Function Design
- Keep functions small and focused (typically <50 lines)
- One function, one purpose
- Descriptive names over comments
- Early returns over nested conditionals

### Error Handling
```python
# Prefer explicit error types
from typing import Union
from pydantic import BaseModel

class ProcessingError(BaseModel):
    message: str
    code: str
    details: Optional[Dict[str, Any]] = None

def process(data: str) -> Union[Result, ProcessingError]:
    if not data:
        return ProcessingError(
            message="Empty input", 
            code="EMPTY_INPUT"
        )
    # Process and return Result
```

### Documentation
- Every module needs a docstring
- Every public function needs a docstring
- Use examples in docstrings for complex functions
- Keep comments minimal - code should be self-documenting

### Testing Standards
- Test file names: `test_<module_name>.py`
- Test class names: `Test<ClassName>`
- Test method names: `test_<method>_<scenario>_<expected>`
- Aim for descriptive test names over comments

## Git Standards

### Branch Naming
```
feat/description-of-feature
fix/issue-description
docs/what-is-documented
refactor/what-is-refactored
test/what-is-tested
```

### Commit Message Examples
```
feat(auth): add OAuth2 GitHub integration
fix(parser): handle Unicode in CSV files
docs(api): update endpoint documentation
refactor(cli): simplify argument parsing
test(models): add edge cases for validation
```

## File Naming Conventions

### General Rules
- Use lowercase with underscores for Python files: `data_processor.py`
- Use kebab-case for directories: `my-feature/`
- Longer descriptive names are preferred: 
  - ✅ `user_authentication_handler.py`
  - ❌ `auth.py`

### Special Files
- `__init__.py` - Package initialization
- `conftest.py` - Pytest configuration and fixtures
- `pyproject.toml` - Project configuration
- `CLAUDE.md` - Claude Code instructions
- Always use `.md` extension for markdown, not `.markdown`

## Performance Considerations

### Memory Efficiency
- Use generators for large datasets
- Prefer itertools over manual loops
- Clean up large objects explicitly when done

### Optimization Guidelines
- Profile before optimizing
- Document performance-critical sections
- Prefer clarity over micro-optimizations
- Note O(n) complexity for non-obvious algorithms

## Security Standards

### Never Commit
- API keys or tokens
- Passwords or credentials  
- Private keys or certificates
- Internal URLs or endpoints
- Personally identifiable information (PII)

### Safe Practices
- Use environment variables for secrets
- Validate all external input
- Sanitize data before storage
- Use parameterized queries
- Keep dependencies updated

## Accessibility and Internationalization

### CLI Output
- Use clear, descriptive messages
- Provide helpful error messages
- Support --help comprehensively
- Use standard exit codes

### User-Facing Text
- Avoid jargon in user messages
- Use consistent terminology
- Prepare for future i18n even if not needed now
- Use Unicode properly