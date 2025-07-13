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

<<<<<<< HEAD
# Remove default config if needed (optional)
# RUN rm /etc/nginx/conf.d/default.conf

# Copy build files to NGINX root directory
COPY --from=build /app/build /usr/share/nginx/html

# OPTIONAL: Add custom nginx.conf here if needed
# COPY nginx.conf /etc/nginx/conf.d/default.conf

# ✅ FIXED: NGINX uses port 80
EXPOSE 80

# Start NGINX
=======
# Copy the built React app to NGINX's default HTML directory
COPY --from=build /app/build /usr/share/nginx/html

# Expose correct port (NGINX uses 80)
EXPOSE 80

# Start NGINX in the foreground
>>>>>>> 497e32f7657b3e23dd57cb94b8b143a2ba0e277f
CMD ["nginx", "-g", "daemon off;"]
