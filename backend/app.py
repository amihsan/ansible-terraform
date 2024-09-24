from flask import Flask, jsonify
from flask_cors import CORS
import os

app = Flask(__name__)
CORS(app)

@app.route('/')
def home():
    # Retrieve secrets from environment variables
    mongodb_uri = os.getenv('MONGODB_URI', 'No MongoDB URI found')
    database_name = os.getenv('DATABASE_NAME', 'No Database Name found')

    return jsonify(
        message="Hello from Flask API!",
        mongodb_uri=mongodb_uri,
        database_name=database_name
    )

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)


# from flask import Flask, jsonify
# from flask_cors import CORS

# app = Flask(__name__)
# CORS(app)  # This will allow all domains to access the API

# @app.route('/')
# def home():
#     return jsonify(message="Hello from Flask API!")

# if __name__ == '__main__':
#     app.run(host='0.0.0.0', port=5000)
