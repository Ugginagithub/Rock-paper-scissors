# Use an official Nginx image to serve the static site
FROM nginx:alpine

# Copy your local HTML, CSS, and JS files to the appropriate directory in the container
COPY . /usr/share/nginx/html

# Expose port 90 to the outside world
EXPOSE 90
