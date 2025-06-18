# Documentation Standards

## Documentation Philosophy

Documentation should:
- Lower cognitive load for future readers
- Persist derived thoughts and conclusions
- Guide Claude Code to relevant context quickly
- Explain "why" more than "what"

## File Documentation

### Module Docstrings
Every Python file should start with a module docstring:

```python
"""User authentication and authorization module.

This module handles OAuth2 authentication with GitHub and manages
user sessions. It integrates with the FastAPI security system and
provides decorators for route protection.

Key components:
- OAuth2 flow implementation
- Session management with Redis
- Role-based access control
- Token refresh logic

Related files:
- models/user.py: User data models
- config/auth.py: Authentication configuration
- tests/test_auth.py: Comprehensive test suite
"""
```

### README Files
Each significant directory should have a README.md:

```markdown
# Scripts Directory

This directory contains utility scripts for development and operations.

## Contents

- `ps-monitor/` - Process monitoring for Claude Code sessions
- `mcp-servers/` - MCP server implementations (future)

## Usage

Scripts are designed to be run with uv:
```bash
uv run scripts/ps-monitor/ps-monitor.py
```

## Contributing

When adding new scripts:
1. Create a subdirectory with descriptive name
2. Include a README.md in the subdirectory
3. Ensure the script has proper shebang and permissions
```

## Function Documentation

### Google-Style Docstrings

```python
def calculate_metrics(
    data: pd.DataFrame,
    window_size: int = 30,
    method: Literal["rolling", "exponential"] = "rolling"
) -> Dict[str, float]:
    """Calculate performance metrics over specified window.
    
    Computes various statistical metrics using either rolling
    or exponential weighted averaging. Handles missing data
    gracefully by forward-filling gaps up to 3 periods.
    
    Args:
        data: Time series data with 'date' index and 'value' column.
            Must be sorted by date with no duplicate indices.
        window_size: Number of periods for calculation window.
            Minimum value is 2.
        method: Averaging method to use:
            - "rolling": Simple moving average
            - "exponential": Exponentially weighted average
            
    Returns:
        Dictionary containing:
            - mean: Average over window
            - std: Standard deviation
            - sharpe: Sharpe ratio (annualized)
            - max_drawdown: Maximum percentage decline
            
    Raises:
        ValueError: If data is empty or window_size < 2
        KeyError: If required columns are missing
        
    Example:
        >>> df = pd.DataFrame({
        ...     'value': [100, 102, 98, 103, 105]
        ... }, index=pd.date_range('2024-01-01', periods=5))
        >>> metrics = calculate_metrics(df, window_size=3)
        >>> print(f"Sharpe ratio: {metrics['sharpe']:.2f}")
        Sharpe ratio: 1.85
        
    Note:
        For financial data, ensure values are adjusted for splits
        and dividends before calculation.
    """
    # Implementation here
    pass
```

### Mathematical Documentation

When implementing mathematical concepts:

```python
def gradient_descent(
    f: Callable[[Array], float],
    x0: Float[Array, "dim"],
    learning_rate: float,
    max_iters: int = 1000
) -> Float[Array, "dim"]:
    """Minimize function using gradient descent.
    
    Implements the standard gradient descent algorithm:
        x_{t+1} = x_t - α ∇f(x_t)
        
    Where:
        - x_t: Current parameter vector
        - α: Learning rate (learning_rate parameter)
        - ∇f: Gradient of objective function
        
    References:
        Nocedal & Wright (2006), Section 3.1
        
    Args:
        f: Objective function to minimize. Must be differentiable.
        x0: Initial parameter vector, shape (dim,)
        learning_rate: Step size α in update rule
        max_iters: Maximum iterations before termination
        
    Returns:
        Optimized parameter vector with same shape as x0
    """
    pass
```

## Code Comments

### When to Comment
- Complex algorithms or non-obvious logic
- Workarounds for library bugs
- Performance-critical sections
- Links to external resources

### Comment Style
```python
# Single-line comment for brief notes

# Multi-line comments should be broken up
# like this for better readability in
# narrow editor windows.

# TODO(jorn): Implement caching here
# FIXME: Temporary workaround for issue #123
# NOTE: This assumes data is pre-sorted

# For complex logic, explain the why:
# We use a heap here instead of sorting because
# we only need the top K elements and N >> K
```

## Project Documentation

### CLAUDE.md Updates
When modifying core functionality, update relevant sections:
- New dependencies → Dependencies section
- New workflows → Workflow Checklists section
- New patterns → Relevant principles section

### Changelog
Follow Keep a Changelog format:
```markdown
## [Unreleased]

### Added
- New ps-monitor tool for process tracking
- Template synchronization workflow

### Changed
- Improved error messages in data processor
- Updated numpy to 1.25.0 for better performance

### Fixed
- Memory leak in streaming endpoint
- Race condition in concurrent file writes
```

### Task Documentation
For complex tasks, create detailed documentation:

```markdown
# Task: Implement Real-time Data Pipeline

## Objective
Create a streaming data pipeline that processes events in real-time
with <100ms latency.

## Context
- Current batch system has 5-minute delay
- Need to support 10K events/second
- Must integrate with existing PostgreSQL

## Approach
1. Use Redis Streams for message queue
2. Implement consumer groups for scaling
3. Write processed data to TimescaleDB

## Success Criteria
- [ ] p99 latency < 100ms
- [ ] Zero message loss
- [ ] Horizontal scaling capability

## Implementation Notes
- Discovered Redis Streams have 1MB message limit
- Using msgpack for serialization (3x faster than JSON)
- Connection pooling critical for performance
```

## API Documentation

### Endpoint Documentation
```python
@app.post("/api/process", response_model=ProcessResult)
async def process_data(
    request: ProcessRequest,
    background_tasks: BackgroundTasks,
    db: Database = Depends(get_db),
    current_user: User = Depends(get_current_user)
):
    """Process incoming data asynchronously.
    
    Validates input data, queues for processing, and returns
    a tracking ID. Processing happens in background task.
    
    **Required permissions**: `data:write`
    
    **Rate limit**: 100 requests per minute
    
    **Request body**:
    - `data`: Raw data to process (max 10MB)
    - `options`: Processing configuration
    - `callback_url`: Optional webhook for completion
    
    **Response**: 
    - `id`: Unique tracking ID
    - `status`: Initial status (always "queued")
    - `estimated_time`: Seconds until completion
    
    **Errors**:
    - `400`: Invalid input data
    - `401`: Missing authentication
    - `403`: Insufficient permissions
    - `413`: Payload too large
    - `429`: Rate limit exceeded
    """
    pass
```

## Reference Documentation

### Cross-References
Use @notation for mandatory context:
```markdown
For implementation details, see @src/core/processor.py
Configuration options are in @config/settings.py
```

Use markdown links for optional context:
```markdown
You might also want to review the [testing guide](../testing/guide.md)
For background, see the [architecture decision](../adr/001-streaming.md)
```

### External References
Always include context for external links:
```markdown
We use the [Aperture algorithm](https://arxiv.org/abs/1234.5678)
for time window calculations. The key insight is that overlapping
windows can share computation (see Section 3.2 of the paper).
```