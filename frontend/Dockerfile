# Stage 1: Build the frontend
FROM node:20.9.0-alpine  AS build

# Set working directory
WORKDIR /app/frontend

# Copy package.json and package-lock.json
COPY frontend/package.json frontend/package-lock.json ./

# Install dependencies
RUN npm install

# Copy the source code
COPY frontend/ ./

# Build the Vite app
RUN npm run build

# Stage 2: Serve the build using Nginx
FROM nginx:alpine

# Copy the Vite build output to Nginx's default public directory
COPY --from=build /app/frontend/dist /usr/share/nginx/html

# Optionally, copy a custom Nginx config file
COPY nginx.conf /etc/nginx/nginx.conf

# Copy the entrypoint script
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# Set the entrypoint
ENTRYPOINT ["/entrypoint.sh"]



