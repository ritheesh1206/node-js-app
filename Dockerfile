# Step 1: Build the React application
FROM node:18 AS build

# Set the working directory
WORKDIR /app

# Copy package.json and package-lock.json (or yarn.lock)
COPY package*.json ./

# Install dependencies in non-interactive mode
RUN npm install --quiet

# Copy the rest of the application code
COPY . .

# Build the React application in non-interactive mode
RUN npm run build --silent

# Step 2: Serve the React application
FROM nginx:alpine

# Copy the build output from the previous stage
COPY --from=build /app/build /usr/share/nginx/html

# Expose the port on which the application will run
EXPOSE 80

# Command to run Nginx in the foreground
CMD ["nginx", "-g", "daemon off;"]
