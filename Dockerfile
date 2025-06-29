FROM python:3.11-slim

WORKDIR /code
COPY requirements.txt .
RUN pip install -r requirements.txt

COPY . .
RUN pip install .

ENV FLASK_APP=app.main
CMD ["gunicorn", "-b", "0.0.0.0:8000", "app.main:app"]
