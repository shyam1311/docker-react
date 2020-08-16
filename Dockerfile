# Build Phase

# Select base image
FROM node:alpine as builder
# Setup Working Directory
WORKDIR '/app'
# Copy Package json to Working Directory
COPY ./package.json ./
# Install Dependencies
RUN npm install
# Copy the rest of the contents
COPY . .
# Run the build command
RUN npm run build

# Run Phase

# Select base image
FROM nginx

EXPOSE 80
# Copy results from builder phase to the nginx setup
COPY --from=builder /app/build /usr/share/nginx/html
