# Makefile for Python Project

.PHONY: help format govee

# Default target when no target is specified
.DEFAULT_GOAL := help

help:
	@echo "Available commands:"
	@echo "  make format    - Format the Python code using UV (e.g., black)"
	@echo "  make help      - Display this help message"

format:
	@echo "Formatting Python code..."
	uv run ruff check --fix src/ tests/
	uv run ruff format src/ tests/

# Build image
build:
	docker compose build

# Run scan (print to stdout)
scan:
	docker compose run --rm govee uv run python -m govee_sync.modules.govee scan

# Run scan and save JSON
scan-json:
	docker compose run --rm govee uv run python -m govee_sync.modules.govee scan --json > dump.json

# Interactive bash
bash:
	docker compose run --rm govee bash

# Cleanup
clean:
	docker compose down --volumes --remove-orphans


