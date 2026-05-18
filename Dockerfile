# Stage 1: Build the Vue app
FROM node:lts AS build

WORKDIR /app

# Install dependencies first (faster cache)
COPY package*.json ./
RUN npm install

# Copy source code -> Destination
COPY . .

# Build production files
RUN npm run build


# Stage 2: Serve with Nginx
FROM nginx:alpine

# Copy build output to nginx html folder
COPY --from=build /app/dist /usr/share/nginx/html

# Expose web port
EXPOSE 80

# Start nginx
CMD ["nginx", "-g", "daemon off;"]