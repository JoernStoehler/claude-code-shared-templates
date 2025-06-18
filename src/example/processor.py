"""Example processor demonstrating integration of models and functions.

This module shows how to combine Pydantic models with pure functions
to create a clean, type-safe API.
"""

from example.calculator import add_numbers, multiply_numbers
from example.models import CalculationRequest, CalculationResult


def process_calculation(request: CalculationRequest) -> CalculationResult:
    """Process a calculation request and return the result.
    
    Args:
        request: The calculation request containing operation and operands.
        
    Returns:
        CalculationResult containing the operation details and result.
        
    Raises:
        ValueError: If the operation is not supported (though this should
            be prevented by the Literal type in the model).
            
    Examples:
        >>> req = CalculationRequest(operation="add", operand_a=5, operand_b=3)
        >>> result = process_calculation(req)
        >>> result.result
        8
    """
    if request.operation == "add":
        result_value = add_numbers(request.operand_a, request.operand_b)
    elif request.operation == "multiply":
        result_value = multiply_numbers(request.operand_a, request.operand_b)
    else:
        # This should never happen due to Literal type constraint
        raise ValueError(f"Unsupported operation: {request.operation}")
    
    return CalculationResult(
        operation=request.operation,
        operand_a=request.operand_a,
        operand_b=request.operand_b,
        result=result_value
    )