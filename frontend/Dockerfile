# Stage 1: Build the React app
FROM node:20.9.0-alpine AS build

WORKDIR /app

COPY package*.json ./
RUN npm install
COPY . .
RUN npm run build

# Stage 2: Serve with Nginx
FROM nginx:alpine

# Copy the build output
COPY --from=build /app/build /usr/share/nginx/html

# Copy a custom entrypoint script
COPY ./entrypoint.sh /usr/share/nginx/entrypoint.sh
RUN chmod +x /usr/share/nginx/entrypoint.sh

# Expose port 80
EXPOSE 80

# Replace default Nginx config
COPY nginx.conf /etc/nginx/nginx.conf

# Start Nginx with the entrypoint script
CMD ["/usr/share/nginx/entrypoint.sh"]



#################

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

# # Build the React app for production
# RUN npm run build

# # Serve the app with a lightweight web server
# RUN npm install -g serve

# # Expose port 3000
# EXPOSE 3000

# # Serve the app
# CMD ["serve", "-s", "build"]





#####################

# # Use a lightweight Node image as the base
# FROM node:20.9.0-alpine as build

# # Set the working directory inside the container
# WORKDIR /app

# # Copy package.json and package-lock.json to install dependencies
# COPY package*.json ./

# # Install dependencies
# RUN npm install

# # Copy the rest of the application code
# COPY . .

# # Inject the REACT_APP_API_URL during build
# ARG REACT_APP_API_URL
# ENV REACT_APP_API_URL=${REACT_APP_API_URL}

# # Build the React application
# RUN npm run build

# # Use a separate lightweight web server image for serving the static files
# FROM nginx:alpine

# ## Remove default nginx index pagec
# RUN rm -rf /usr/share/nginx/html/*

# # Copy the built static files from the previous stage to the NGINX image
# COPY --from=build /app/build /usr/share/nginx/html

# # Expose port 80 (default port for HTTP)
# EXPOSE 80

# # Start NGINX to serve the static files
# CMD ["nginx", "-g", "daemon off;"]

