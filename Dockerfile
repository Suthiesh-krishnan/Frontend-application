# Step 1: Build the app using Node.js
FROM node:16 AS build

WORKDIR /app

# Copy dependencies and install them
COPY package.json package-lock.json ./
RUN npm install

# Copy the rest of the source code
COPY . .

# Build the React app
RUN npm run build

# Step 2: Serve the app using NGINX
FROM nginx:alpine

# Copy the built React app to NGINX's default HTML directory
COPY --from=build /app/build /usr/share/nginx/html

# Expose correct port (NGINX uses 80)
EXPOSE 80

# Start NGINX in the foreground
CMD ["nginx", "-g", "daemon off;"]
