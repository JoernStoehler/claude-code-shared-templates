"""Example module demonstrating project structure and best practices.

This module shows how to structure code following the principles in docs/claude/development/.
"""

from typing import Union

from pydantic import BaseModel, Field


class DataPoint(BaseModel):
    """Example data model using Pydantic for validation."""
    
    value: float = Field(..., description="Numeric value")
    label: str = Field(..., min_length=1, description="Data label")
    metadata: dict = Field(default_factory=dict, description="Optional metadata")


class ProcessingError(BaseModel):
    """Error model for processing failures."""
    
    message: str
    code: str
    details: dict = Field(default_factory=dict)


def process_data(data: DataPoint) -> Union[DataPoint, ProcessingError]:
    """Process a data point following pure function principles.
    
    This is an example of a pure function that:
    - Takes immutable input (Pydantic model)
    - Returns either success or error (no exceptions for expected failures)
    - Has no side effects
    
    Args:
        data: Input data point to process
        
    Returns:
        Processed data point or error if processing fails
    """
    # Example validation
    if data.value < 0:
        return ProcessingError(
            message="Value must be non-negative",
            code="INVALID_VALUE",
            details={"value": data.value}
        )
    
    # Example processing (pure transformation)
    processed = data.model_copy(update={
        "value": data.value * 2,
        "metadata": {**data.metadata, "processed": True}
    })
    
    return processed


def add_numbers(a: float, b: float) -> float:
    """Add two numbers together.
    
    Simple example function for testing.
    
    Args:
        a: First number
        b: Second number
        
    Returns:
        Sum of a and b
    """
    return a + b