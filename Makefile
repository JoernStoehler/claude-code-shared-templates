.PHONY: help install install-dev install-ci install-animations install-slides install-ai install-scientific install-web test lint typecheck dev run clean

# Default target
help:
	@echo "Available commands:"
	@echo "  make install         - Install core runtime dependencies only"
	@echo "  make install-dev     - Install all dev dependencies (includes everything)"
	@echo "  make install-ci      - Install minimal CI dependencies (for GitHub Actions)"
	@echo "  make install-animations - Install dependencies for mathematical animations"
	@echo "  make install-slides  - Install dependencies for slides/notes creation"
	@echo "  make install-ai      - Install AI/ML benchmarking dependencies"
	@echo "  make install-scientific - Install advanced scientific computing dependencies"
	@echo "  make install-web     - Install web application dependencies"
	@echo "  make test            - Run tests with coverage"
	@echo "  make lint            - Run linter (ruff)"
	@echo "  make typecheck       - Run type checker (pyright)"
	@echo "  make dev             - Run development server with hot-reload"
	@echo "  make run             - Run production server"
	@echo "  make clean           - Clean up generated files and caches"

# Install core runtime dependencies only
install:
	@echo "Installing core runtime dependencies..."
	uv sync --frozen

# Install all development dependencies
install-dev:
	@echo "Installing all development dependencies..."
	uv sync --frozen --extra dev --extra animations --extra slides --extra ai --extra scientific --extra web

# Install minimal CI dependencies
install-ci:
	@echo "Installing minimal CI dependencies..."
	uv sync --frozen --extra ci

# Install animation dependencies
install-animations:
	@echo "Installing animation dependencies (requires system deps: libcairo2-dev, libpango1.0-dev, ffmpeg)..."
	uv sync --frozen --extra animations

# Install slides/notes dependencies
install-slides:
	@echo "Installing slides/notes dependencies (note: Quarto must be installed separately)..."
	uv sync --frozen --extra slides

# Install AI/ML dependencies
install-ai:
	@echo "Installing AI/ML benchmarking dependencies..."
	uv sync --frozen --extra ai

# Install scientific computing dependencies
install-scientific:
	@echo "Installing advanced scientific computing dependencies..."
	uv sync --frozen --extra scientific

# Install web application dependencies
install-web:
	@echo "Installing web application dependencies..."
	uv sync --frozen --extra web

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