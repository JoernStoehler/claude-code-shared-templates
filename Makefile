.PHONY: help install test lint typecheck dev run clean

# Default target
help:
	@echo "Available commands:"
	@echo "  make install    - Install all dependencies including dev dependencies"
	@echo "  make test       - Run tests with coverage"
	@echo "  make lint       - Run linter (ruff)"
	@echo "  make typecheck  - Run type checker (pyright)"
	@echo "  make dev        - Run development server with hot-reload"
	@echo "  make run        - Run production server"
	@echo "  make clean      - Clean up generated files and caches"

# Install all dependencies
install:
	@echo "Installing dependencies with uv..."
	uv sync

# Run tests
test:
	@echo "Running tests with pytest..."
	uv run pytest -x

# Run linter
lint:
	@echo "Running ruff linter..."
	uv run ruff check .

# Run type checker
typecheck:
	@echo "Running pyright type checker..."
	uv run pyright .

# Run development server with hot-reload
dev:
	@echo "Starting development server..."
	@if [ -f "app/main.py" ]; then \
		uv run uvicorn app.main:app --reload; \
	else \
		echo "No FastAPI app found at app/main.py"; \
		echo "For testing purposes, running example module..."; \
		uv run python -c "from example.processor import process_calculation; from example.models import CalculationRequest; req = CalculationRequest(operation='add', operand_a=5, operand_b=3); result = process_calculation(req); print(f'Result: {result.result}')"; \
	fi

# Run production server
run:
	@echo "Starting production server..."
	@if [ -f "app/main.py" ]; then \
		uv run uvicorn app.main:app; \
	else \
		echo "No FastAPI app found at app/main.py"; \
		echo "For testing purposes, running example module..."; \
		uv run python -m example; \
	fi

# Clean up generated files and caches
clean:
	@echo "Cleaning up..."
	find . -type d -name "__pycache__" -exec rm -rf {} + 2>/dev/null || true
	find . -type d -name ".pytest_cache" -exec rm -rf {} + 2>/dev/null || true
	find . -type d -name ".ruff_cache" -exec rm -rf {} + 2>/dev/null || true
	find . -type d -name "htmlcov" -exec rm -rf {} + 2>/dev/null || true
	find . -type f -name "*.pyc" -delete 2>/dev/null || true
	find . -type f -name ".coverage" -delete 2>/dev/null || true
	find . -type f -name "coverage.xml" -delete 2>/dev/null || true