# Makefile for Python Project

.PHONY: help format

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
