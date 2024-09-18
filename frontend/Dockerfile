# Use node base image
FROM node:20.9.0-alpine

# Set the working directory in the container
WORKDIR /app

# Copy the package.json and package-lock.json first for better build caching
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy the rest of the application
COPY . .

# Inject the REACT_APP_API_URL during build
ARG REACT_APP_API_URL
ENV REACT_APP_API_URL=${REACT_APP_API_URL}


# Build the React app for production
RUN npm run build

# Serve the app with a lightweight web server
RUN npm install -g serve

# Expose port 3000
EXPOSE 3000

# Serve the app
CMD ["serve", "-s", "build"]
