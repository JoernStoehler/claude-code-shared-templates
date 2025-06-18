"""Tests for the processor module demonstrating integration testing."""

import pytest
from pydantic import ValidationError

from example.models import CalculationRequest, CalculationResult
from example.processor import process_calculation


class TestProcessCalculation:
    """Test cases for process_calculation function."""
    
    def test_process_add_request(self):
        """Test processing an addition request."""
        request = CalculationRequest(
            operation="add",
            operand_a=5,
            operand_b=3
        )
        result = process_calculation(request)
        
        assert isinstance(result, CalculationResult)
        assert result.operation == "add"
        assert result.operand_a == 5
        assert result.operand_b == 3
        assert result.result == 8
    
    def test_process_multiply_request(self):
        """Test processing a multiplication request."""
        request = CalculationRequest(
            operation="multiply",
            operand_a=4,
            operand_b=7
        )
        result = process_calculation(request)
        
        assert isinstance(result, CalculationResult)
        assert result.operation == "multiply"
        assert result.operand_a == 4
        assert result.operand_b == 7
        assert result.result == 28
    
    def test_process_with_floats(self):
        """Test processing with floating point numbers."""
        request = CalculationRequest(
            operation="multiply",
            operand_a=2.5,
            operand_b=4
        )
        result = process_calculation(request)
        
        assert result.result == 10.0
    
    def test_result_immutability(self):
        """Test that the returned result is immutable."""
        request = CalculationRequest(
            operation="add",
            operand_a=10,
            operand_b=20
        )
        result = process_calculation(request)
        
        with pytest.raises(ValidationError):
            result.result = 999