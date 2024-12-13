# Base image
FROM python:3.11

# Environment variables
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

# Install dependencies
RUN apt-get update && apt-get install -y \
    build-essential \
    python3-dev \
    python3-pip \
    python3-distutils \
    && apt-get clean

# Upgrade pip to the latest version
RUN python3 -m pip install --upgrade pip


# Copy project files into container
COPY . .

# Create and activate virtual environment
RUN python3 -m venv venv

# Install dependencies from requirements.txt
RUN venv/bin/pip install --no-cache-dir -r requirements.txt

# Run database migrations
RUN venv/bin/python manage.py migrate

# Command to run the application
CMD ["venv/bin/python", "manage.py", "runserver", "0.0.0.0:8000"]
