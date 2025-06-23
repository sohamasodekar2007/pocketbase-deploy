FROM alpine:latest

# Install required packages
RUN apk add --no-cache curl unzip libc6-compat

# Set working directory
WORKDIR /app

# Download PocketBase binary (adjust version as needed)
RUN curl -L https://github.com/pocketbase/pocketbase/releases/download/v0.28.4/pocketbase_0.28.4_linux_amd64.zip -o pb.zip && \
    unzip pb.zip && \
    rm pb.zip && \
    chmod +x pocketbase

# Copy start script and entrypoint
COPY start.sh /app/start.sh
COPY entrypoint.sh /app/entrypoint.sh
RUN chmod +x /app/start.sh /app/entrypoint.sh

# Expose port
EXPOSE 8090

# Run entrypoint
ENTRYPOINT ["/app/entrypoint.sh"]
