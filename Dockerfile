# ===== Stage 1: builder (builds the static site with Parcel) =====
# Use a pinned Node image, no :latest
FROM node:22-alpine AS builder

# Set the working directory inside the container
WORKDIR /app

# Copy only package files first so the npm install layer is cached
COPY package*.json ./

# Install exact dependency versions from package-lock.json
RUN npm ci

# Copy the website source and shared styles
COPY src/ ./src/
COPY styles/ ./styles/

# Build all pages into /app/dist
RUN npm run build

# ===== Stage 2: runtime (serves the built files with Nginx) =====
# Pinned small Nginx image, no Node.js or node_modules in the final image
FROM nginx:1.27-alpine

# Copy only the built static files from the builder stage
COPY --from=builder /app/dist /usr/share/nginx/html

# Document that the container listens on port 80
EXPOSE 80

# Run Nginx in the foreground so the container stays alive
CMD ["nginx", "-g", "daemon off;"]