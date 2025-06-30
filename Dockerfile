FROM python:3.13-slim

WORKDIR /code

# # Install dependencies as root
# RUN apt-get update && apt-get install -y --no-install-recommends curl \
#     && apt-get clean \
#     && rm -rf /var/lib/apt/lists/*

# Copy application code
COPY ./app .

# Create and use a virtual environment for installing Python dependencies
RUN python -m venv /code/venv
ENV PATH="/code/venv/bin:$PATH"

# Install Python dependencies in the virtual environment
RUN pip install --upgrade pip \
    && pip install -r requirements.txt

# Create the appuser
RUN groupadd -r appuser && useradd -r -g appuser appuser \
    && chown -R appuser:appuser /code

# Switch to non-root user AFTER all installation tasks
USER appuser

ENV FLASK_APP=app
ENV DEPLOY_ENV=docker
EXPOSE 8000
CMD ["gunicorn", "-b", "0.0.0.0:8000", "app:app"]