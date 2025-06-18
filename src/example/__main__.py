"""Main entry point for the example module when run as a script."""

from example.models import CalculationRequest
from example.processor import process_calculation


def main():
    """Run example calculations to demonstrate the module."""
    # Example addition
    add_request = CalculationRequest(operation="add", operand_a=5, operand_b=3)
    add_result = process_calculation(add_request)
    print(f"Addition: {add_result.operand_a} + {add_result.operand_b} = {add_result.result}")
    
    # Example multiplication
    mult_request = CalculationRequest(operation="multiply", operand_a=4, operand_b=7)
    mult_result = process_calculation(mult_request)
    print(f"Multiplication: {mult_result.operand_a} x {mult_result.operand_b} = {mult_result.result}")


if __name__ == "__main__":
    main()