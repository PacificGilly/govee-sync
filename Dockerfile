FROM python:3.13-slim

# Add uv to PATH
ENV PATH="$HOME/.local/bin:$PATH"

# Install system deps for bluetooth + dbus
RUN apt-get update && apt-get install -y \
    bluez dbus gcc libglib2.0-dev \
 && rm -rf /var/lib/apt/lists/*

# Install uv (fast Python package/dependency manager)
RUN pip install --no-cache-dir uv

# Set working directory
WORKDIR /app

# Copy project files
COPY pyproject.toml uv.lock* ./
COPY src ./src

# Install dependencies with uv
RUN uv sync --frozen --no-install-project

# Default command (overridable in docker-compose/Makefile)
CMD ["uv", "run", "python", "-m", "govee_sync.modules.govee", "scan"]
