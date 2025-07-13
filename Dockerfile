# Step 1: Build the app using Node.js
FROM node:16 AS build

WORKDIR /app

# Copy dependencies and install them
COPY package.json package-lock.json ./
RUN npm install

# Copy the source code
COPY . .

# Build the React app
RUN npm run build

# Step 2: Serve the app using NGINX
FROM nginx:alpine

# Remove default config if needed (optional)
# RUN rm /etc/nginx/conf.d/default.conf

# Copy build files to NGINX root directory
COPY --from=build /app/build /usr/share/nginx/html

# OPTIONAL: Add custom nginx.conf here if needed
# COPY nginx.conf /etc/nginx/conf.d/default.conf

# ✅ FIXED: NGINX uses port 80
EXPOSE 80

# Start NGINX
CMD ["nginx", "-g", "daemon off;"]
