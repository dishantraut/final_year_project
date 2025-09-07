FROM python:3.11-alpine AS base

# Prevent Python from writing .pyc files and enable unbuffered stdout/stderr
ENV PYTHONDONTWRITEBYTECODE=1 \
	PYTHONUNBUFFERED=1

# Install system dependencies required for building some Python packages and
# for runtime. This image is based on Alpine, so use apk instead of apt-get.
RUN apk add --no-cache build-base ca-certificates curl

WORKDIR /app

# Copy only requirements first to leverage Docker layer caching for dependencies
COPY requirements.txt ./

# Upgrade pip and install Python dependencies. Use --no-cache-dir to keep image small.
RUN pip install --upgrade pip \
	&& pip install --no-cache-dir -r requirements.txt

# Copy application source
COPY . .

# Create an unprivileged user and ensure ownership of application files
# Use Alpine's addgroup/adduser for portability on alpine images.
RUN addgroup -S appuser \
	&& adduser -S -G appuser appuser \
	&& chown -R appuser:appuser /app

USER appuser

# Expose the default HTTP port the app will listen on
EXPOSE 8000

# Default command to run the app using Gunicorn (production-ready server).
# If your app uses a different entrypoint, replace this with the correct command.
# TODO : Decide the command later
# CMD ["gunicorn", "app:app", "--bind", "0.0.0.0:8000", "--workers", "2"]
