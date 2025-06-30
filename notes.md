# Setup

cd app
python3 -m venv env
source env/bin/activate
python -m pip install --upgrade pip
pip install -r requirements.txt
gunicorn --bind=0.0.0.0 --timeout 600 app:app

# Create Image
docker build -t flask-app . 

docker run -p 8000:8000 flask-app