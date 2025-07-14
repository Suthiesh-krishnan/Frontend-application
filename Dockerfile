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

# Optional: Remove default config if needed
# RUN rm /etc/nginx/conf.d/default.conf

# Copy the built React app to NGINX's default HTML directory
COPY --from=build /app/build /usr/share/nginx/html

# Optional: Add a custom nginx.conf
# COPY nginx.conf /etc/nginx/conf.d/default.conf

# Expose the default NGINX port
EXPOSE 80

# Start NGINX in the foreground
CMD ["nginx", "-g", "daemon off;"]
