# Use an official Node.js image to build the app
FROM node:20.9.0-alpine AS build

# Define build-time argument
ARG REACT_APP_API_URL

# Set environment variable for build-time
ENV REACT_APP_API_URL=$REACT_APP_API_URL

# Set working directory inside the container
WORKDIR /app

# Copy the package.json and install dependencies
COPY package.json /app
RUN npm install

# Copy the rest of the application code
COPY . /app

# Build the app
RUN npm run build

# Use a simple server to serve the built app
FROM nginx:alpine
COPY --from=build /app/build /usr/share/nginx/html

# Expose port 80 for the server
EXPOSE 80

# Start Nginx server
CMD ["nginx", "-g", "daemon off;"]


# # Use node base image
# FROM node:20.9.0-alpine

# # Set the working directory in the container
# WORKDIR /app

# # Copy the package.json and package-lock.json first for better build caching
# COPY package*.json ./

# # Install dependencies
# RUN npm install

# # Copy the rest of the application
# COPY . .

# # Inject the REACT_APP_API_URL during build
# ARG REACT_APP_API_URL
# ENV REACT_APP_API_URL=${REACT_APP_API_URL}


# # Build the React app for production
# RUN npm run build

# # Serve the app with a lightweight web server
# RUN npm install -g serve

# # Expose port 3000
# EXPOSE 3000

# # Serve the app
# CMD ["serve", "-s", "build"]
