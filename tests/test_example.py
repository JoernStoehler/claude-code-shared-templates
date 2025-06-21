"""Tests for the example module."""

import pytest

from myproject.example import DataPoint, ProcessingError, add_numbers, process_data


class TestDataModels:
    """Test Pydantic models."""
    
    def test_data_point_creation(self):
        """Test creating a valid data point."""
        data = DataPoint(value=42.0, label="test")
        assert data.value == 42.0
        assert data.label == "test"
        assert data.metadata == {}
    
    def test_data_point_with_metadata(self):
        """Test data point with metadata."""
        data = DataPoint(
            value=10.0,
            label="example",
            metadata={"source": "test"}
        )
        assert data.metadata["source"] == "test"
    
    def test_processing_error(self):
        """Test error model creation."""
        error = ProcessingError(
            message="Test error",
            code="TEST_ERROR",
            details={"info": "additional"}
        )
        assert error.message == "Test error"
        assert error.code == "TEST_ERROR"


class TestProcessing:
    """Test data processing functions."""
    
    def test_process_valid_data(self):
        """Test processing valid data."""
        data = DataPoint(value=10.0, label="test")
        result = process_data(data)
        
        assert isinstance(result, DataPoint)
        assert result.value == 20.0  # Doubled
        assert result.metadata["processed"] is True
    
    def test_process_invalid_data(self):
        """Test processing invalid data returns error."""
        data = DataPoint(value=-5.0, label="negative")
        result = process_data(data)
        
        assert isinstance(result, ProcessingError)
        assert result.code == "INVALID_VALUE"
        assert result.details["value"] == -5.0
    
    def test_process_preserves_original(self):
        """Test that processing doesn't modify original data."""
        original = DataPoint(value=15.0, label="original")
        result = process_data(original)
        
        # Original should be unchanged
        assert original.value == 15.0
        assert "processed" not in original.metadata


class TestAddNumbers:
    """Test the simple add_numbers function."""
    
    def test_add_positive_numbers(self):
        """Test adding positive numbers."""
        assert add_numbers(2, 3) == 5
    
    def test_add_negative_numbers(self):
        """Test adding negative numbers."""
        assert add_numbers(-2, -3) == -5
    
    def test_add_zero(self):
        """Test adding with zero."""
        assert add_numbers(5, 0) == 5
        assert add_numbers(0, 0) == 0
    
    @pytest.mark.parametrize("a,b,expected", [
        (1, 1, 2),
        (10, 20, 30),
        (-5, 5, 0),
        (0.1, 0.2, 0.3),
    ])
    def test_add_various_inputs(self, a, b, expected):
        """Test with various inputs."""
        assert add_numbers(a, b) == pytest.approx(expected)