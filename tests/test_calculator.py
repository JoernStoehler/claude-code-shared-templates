"""Tests for calculator functions demonstrating TDD approach.

These tests were written before the implementation following
the test-driven development principle.
"""

import pytest

from example.calculator import add_numbers, multiply_numbers


class TestAddNumbers:
    """Test cases for the add_numbers function."""
    
    def test_add_positive_integers(self):
        """Test adding two positive integers."""
        assert add_numbers(2, 3) == 5
        assert add_numbers(10, 20) == 30
    
    def test_add_negative_numbers(self):
        """Test adding negative numbers."""
        assert add_numbers(-5, 3) == -2
        assert add_numbers(-5, -3) == -8
    
    def test_add_floats(self):
        """Test adding floating point numbers."""
        assert add_numbers(2.5, 3.7) == 6.2
        assert add_numbers(0.1, 0.2) == pytest.approx(0.3)
    
    def test_add_mixed_types(self):
        """Test adding integer and float."""
        assert add_numbers(5, 2.5) == 7.5
        assert add_numbers(2.5, 5) == 7.5


class TestMultiplyNumbers:
    """Test cases for the multiply_numbers function."""
    
    def test_multiply_positive_integers(self):
        """Test multiplying two positive integers."""
        assert multiply_numbers(3, 4) == 12
        assert multiply_numbers(5, 6) == 30
    
    def test_multiply_with_zero(self):
        """Test multiplying with zero."""
        assert multiply_numbers(5, 0) == 0
        assert multiply_numbers(0, 10) == 0
    
    def test_multiply_negative_numbers(self):
        """Test multiplying negative numbers."""
        assert multiply_numbers(-3, 4) == -12
        assert multiply_numbers(-3, -4) == 12
    
    def test_multiply_floats(self):
        """Test multiplying floating point numbers."""
        assert multiply_numbers(2.5, 4) == 10.0
        assert multiply_numbers(0.5, 0.5) == 0.25