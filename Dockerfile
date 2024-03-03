# Use official Node.js image as the base image
FROM node:14.21.3 as build

# Set the working directory in the container
WORKDIR ./app

# Copy package.json and package-lock.json to the working directory
COPY package*.json ./

# Install Angular CLI globally
RUN npm install -g @angular/cli@9.1.7

# Install dependencies
RUN npm install

# Copy the entire application directory to the container
COPY . .

# Build the Angular app for production
RUN npm build-prod

# Use NGINX as the production server
FROM nginx:1.21.5-alpine

# Copy the built Angular app from the previous stage to NGINX's HTML directory
COPY --from=build /Users/dillikarchaitanya/.jenkins/workspace/angular-deploy/dist /opt/homebrew/bin/nginx

# Expose port 80 to the outside world
EXPOSE 80

# Start NGINX when the container starts
CMD ["nginx", "-g", "daemon off;"]
