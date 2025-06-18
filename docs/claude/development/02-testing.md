# Testing Guidelines

## Test-Driven Development (TDD)

We follow strict TDD practices:

1. **Write tests first** - Before implementing any functionality
2. **Verify tests fail** - Ensure tests actually test the intended behavior
3. **Implement code** - Write minimal code to pass tests
4. **Refactor** - Only refactor tests if necessary
5. **Add edge cases** - Ensure robustness with comprehensive tests

## Testing Tools

### Core Tools
- `pytest` - Test runner
- `pytest-cov` - Coverage reporting
- `pytest-xdist` - Parallel test execution

### Commands
```bash
# Run all tests
uv run pytest

# Run with coverage
uv run pytest --cov

# Run specific test file
uv run pytest tests/test_module.py

# Run tests in parallel
uv run pytest -n auto

# Stop on first failure
uv run pytest -x
```

## Coverage Requirements

- Target: ≥80% test coverage
- Check coverage: `uv run pytest --cov --cov-report=html`
- View report: Open `htmlcov/index.html`

## Test Structure

```python
# tests/test_feature.py
import pytest
from mymodule import MyClass, MyError

class TestMyClass:
    """Test suite for MyClass functionality."""
    
    def test_basic_functionality(self):
        """Test the happy path."""
        obj = MyClass(value=42)
        assert obj.compute() == 84
    
    def test_edge_case_zero(self):
        """Test behavior with zero input."""
        obj = MyClass(value=0)
        assert obj.compute() == 0
    
    def test_error_handling(self):
        """Test error conditions."""
        obj = MyClass(value=-1)
        result = obj.compute()
        assert isinstance(result, MyError)
        assert result.code == "INVALID_INPUT"
    
    @pytest.mark.parametrize("value,expected", [
        (1, 2),
        (10, 20),
        (100, 200),
    ])
    def test_multiple_inputs(self, value, expected):
        """Test with various inputs."""
        obj = MyClass(value=value)
        assert obj.compute() == expected
```

## Best Practices

1. **Test organization**
   - Mirror source structure in tests/
   - One test file per source module
   - Group related tests in classes

2. **Test naming**
   - Use descriptive names: `test_<what>_<condition>_<expected>`
   - Document test purpose in docstrings

3. **Fixtures**
   - Use pytest fixtures for common setup
   - Keep fixtures in conftest.py
   - Prefer function-scoped fixtures

4. **Assertions**
   - One logical assertion per test
   - Use specific assertions (not just `assert x`)
   - Include helpful assertion messages

5. **Performance**
   - Keep individual tests fast (<1 second)
   - Use mocks for external dependencies
   - Mark slow tests with `@pytest.mark.slow`