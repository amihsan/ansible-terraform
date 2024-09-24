from flask import Flask
from flask_cors import CORS
from routes.main_routes import bp

app = Flask(__name__)
CORS(app)

app.register_blueprint(bp)

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
