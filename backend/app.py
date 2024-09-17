from flask import Flask, jsonify
from flask_cors import CORS

app = Flask(__name__)
CORS(app)  # This will allow all domains to access the API

@app.route('/')
def home():
    return jsonify(message="Hello from Flask API!")

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)
