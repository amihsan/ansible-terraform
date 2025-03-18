# Use the official Node.js image to build the React app
FROM node:20.9.0-alpine as build

# Set working directory
WORKDIR /app

# Install dependencies
COPY package.json ./
COPY package-lock.json ./
RUN npm install

# Copy and build the Vite project
COPY . ./
RUN npm run build

# Update Browserslist: caniuse-lite
RUN npx update-browserslist-db@latest

## The second stage
# Copy build files and start nginx
FROM nginx:alpine

# Copy the built static files from the build stage to the nginx directory
COPY --from=build /app/frontend/dist /usr/share/nginx/html

COPY nginx.conf /etc/nginx/nginx.conf

# Copy the entrypoint script
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# Set the entrypoint
ENTRYPOINT ["/entrypoint.sh"]



