#!/bin/sh

# Replace placeholders with environment variable values
envsubst '${REACT_APP_API_URL}' < /usr/share/nginx/html/index.html > /usr/share/nginx/html/index.html.tmp
mv /usr/share/nginx/html/index.html.tmp /usr/share/nginx/html/index.html

# Start Nginx
nginx -g 'daemon off;'
