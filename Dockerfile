# Step 1: Use Go image to build
FROM golang:1.20-alpine AS builder

RUN apk add --no-cache git

WORKDIR /app

COPY . .

RUN go mod tidy
RUN go build -o pocketbase .

# Step 2: Use clean Alpine for running
FROM alpine:latest

RUN apk add --no-cache libc6-compat curl

WORKDIR /app

COPY --from=builder /app/pocketbase ./pocketbase
COPY start.sh ./start.sh
COPY entrypoint.sh ./entrypoint.sh

RUN chmod +x ./start.sh ./entrypoint.sh

EXPOSE 8090

ENTRYPOINT ["./entrypoint.sh"]
