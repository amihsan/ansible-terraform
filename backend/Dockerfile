# Use a base image with Python pre-installed
FROM python:3.9.12-alpine

# Set the working directory inside the container
WORKDIR /app

# Copy and install requirements
COPY requirements.txt /app/requirements.txt
RUN pip install --no-cache-dir -r requirements.txt

# Copy the entire project to the working directory
COPY . .

# Expose the port the app runs on
EXPOSE 5000

# Command to run the application
CMD ["gunicorn", "-b", "0.0.0.0:5000", "app:app"]



# # Use Python base image
# FROM python:3.9.12-alpine

# # Set the working directory in the container
# WORKDIR /app

# # Copy the requirements file into the container
# COPY requirements.txt .

# # Install the Python dependencies
# RUN pip install -r requirements.txt

# # Copy the Flask app code into the container
# COPY . .

# # Expose the Flask app port
# EXPOSE 5000

# # Run the Flask app
# CMD ["python", "app.py"]
