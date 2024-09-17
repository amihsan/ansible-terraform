# Use node base image
FROM node:20.9.0-alpine

# Set the working directory in the container
WORKDIR /app

# Copy the React app code into the container
COPY . .

# Install the dependencies
RUN npm install

# Build the React app
RUN npm run build

# Serve the app with a lightweight web server
RUN npm install -g serve

# Expose port 3000
EXPOSE 3000

# Serve the app
CMD ["serve", "-s", "build"]
