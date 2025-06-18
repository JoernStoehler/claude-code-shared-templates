"""Simple calculator functions demonstrating pure functions and type annotations.

This module implements basic arithmetic operations following the project's
principles of using pure functions with clear type annotations.
"""



def add_numbers(a: int | float, b: int | float) -> int | float:
    """Add two numbers together.
    
    Args:
        a: First number to add.
        b: Second number to add.
        
    Returns:
        Sum of a and b.
        
    Examples:
        >>> add_numbers(2, 3)
        5
        >>> add_numbers(2.5, 3.7)
        6.2
    """
    return a + b


def multiply_numbers(a: int | float, b: int | float) -> int | float:
    """Multiply two numbers together.
    
    Args:
        a: First number to multiply.
        b: Second number to multiply.
        
    Returns:
        Product of a and b.
        
    Examples:
        >>> multiply_numbers(3, 4)
        12
        >>> multiply_numbers(2.5, 4)
        10.0
    """
    return a * b