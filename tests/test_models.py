"""Tests for Pydantic models demonstrating validation and immutability."""

import pytest
from pydantic import ValidationError

from example.models import CalculationRequest, CalculationResult


class TestCalculationRequest:
    """Test cases for CalculationRequest model."""
    
    def test_valid_add_request(self):
        """Test creating a valid add request."""
        request = CalculationRequest(
            operation="add",
            operand_a=5,
            operand_b=3
        )
        assert request.operation == "add"
        assert request.operand_a == 5
        assert request.operand_b == 3
    
    def test_valid_multiply_request_with_floats(self):
        """Test creating a valid multiply request with floats."""
        request = CalculationRequest(
            operation="multiply",
            operand_a=2.5,
            operand_b=4.0
        )
        assert request.operation == "multiply"
        assert request.operand_a == 2.5
        assert request.operand_b == 4.0
    
    def test_invalid_operation(self):
        """Test that invalid operations are rejected."""
        with pytest.raises(ValidationError) as exc_info:
            CalculationRequest(
                operation="divide",  # type: ignore  # Not in Literal["add", "multiply"]
                operand_a=10,
                operand_b=2
            )
        assert "operation" in str(exc_info.value)
    
    def test_missing_fields(self):
        """Test that missing required fields raise validation errors."""
        with pytest.raises(ValidationError) as exc_info:
            CalculationRequest(operation="add")  # type: ignore
        assert "operand_a" in str(exc_info.value)
        assert "operand_b" in str(exc_info.value)
    
    def test_immutability(self):
        """Test that the model is immutable (frozen)."""
        request = CalculationRequest(
            operation="add",
            operand_a=5,
            operand_b=3
        )
        with pytest.raises(ValidationError):
            request.operand_a = 10


class TestCalculationResult:
    """Test cases for CalculationResult model."""
    
    def test_valid_result(self):
        """Test creating a valid calculation result."""
        result = CalculationResult(
            operation="add",
            operand_a=5,
            operand_b=3,
            result=8
        )
        assert result.operation == "add"
        assert result.operand_a == 5
        assert result.operand_b == 3
        assert result.result == 8
    
    def test_float_result(self):
        """Test result with floating point numbers."""
        result = CalculationResult(
            operation="multiply",
            operand_a=2.5,
            operand_b=4,
            result=10.0
        )
        assert result.result == 10.0
    
    def test_immutability(self):
        """Test that the result model is immutable."""
        result = CalculationResult(
            operation="add",
            operand_a=5,
            operand_b=3,
            result=8
        )
        with pytest.raises(ValidationError):
            result.result = 10