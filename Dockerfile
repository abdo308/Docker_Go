# Build stage
FROM golang:1.21 AS builder
WORKDIR /app
COPY . .
RUN go build -o app

# Final stage
FROM debian:bullseye-slim
WORKDIR /app
COPY --from=builder /app/app .
CMD ["./app"]