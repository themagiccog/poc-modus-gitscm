from flask import Flask, jsonify
import pkg_resources

app = Flask(__name__)

@app.route("/")
def index():
    version = "1.0.0"
    return jsonify({"message": "Hello from Flask!", "version": version})

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)
