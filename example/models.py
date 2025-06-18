"""Pydantic models for data validation in the example module.

This module demonstrates the use of Pydantic for data validation
and serialization, following the project principle of using
immutable data structures with validation.
"""

from typing import Literal

from pydantic import BaseModel, Field


class CalculationRequest(BaseModel):
    """Request model for calculator operations.
    
    Attributes:
        operation: The mathematical operation to perform.
        operand_a: First operand.
        operand_b: Second operand.
    """
    
    operation: Literal["add", "multiply"]
    operand_a: int | float = Field(..., description="First operand")
    operand_b: int | float = Field(..., description="Second operand")
    
    model_config = {
        "frozen": True,  # Make the model immutable
        "json_schema_extra": {
            "examples": [
                {
                    "operation": "add",
                    "operand_a": 5,
                    "operand_b": 3
                },
                {
                    "operation": "multiply",
                    "operand_a": 2.5,
                    "operand_b": 4
                }
            ]
        }
    }


class CalculationResult(BaseModel):
    """Result model for calculator operations.
    
    Attributes:
        operation: The operation that was performed.
        operand_a: First operand used.
        operand_b: Second operand used.
        result: The result of the calculation.
    """
    
    operation: Literal["add", "multiply"]
    operand_a: int | float
    operand_b: int | float
    result: int | float
    
    model_config = {
        "frozen": True,  # Make the model immutable
    }