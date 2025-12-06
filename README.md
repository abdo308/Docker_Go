# Docker_Go

This project demonstrates a simple Go application containerized using Docker, with a focus on **multistage builds** for efficient and secure deployment.

## Multistage Build Explanation

Multistage builds in Docker allow you to use multiple `FROM` statements in your `Dockerfile`. This technique lets you build your Go application in one stage (using a full Go environment), and then copy only the compiled binary into a minimal image (like `debian:bullseye-slim`) for production. This results in smaller, more secure, and efficient containers. The size of the image is roughly 84MB.

### Benefits

- **Smaller image size:** Only the compiled binary and necessary files are included.
- **Faster deployment:** Less data to transfer and start.
- **Security:** No build tools or unnecessary files in the final image.

## Example Dockerfile Structure

```dockerfile
# Build stage
FROM golang:1.21 AS builder
WORKDIR /app
COPY . .
RUN go build -o main .

# Final stage
FROM debian:bullseye-slim
WORKDIR /app
COPY --from=builder /app/app .
CMD ["./app"]
```

## How to Build and Run

```bash
docker build -t docker_go .
docker run --rm -p 8080:8080 docker_go
```

## Project Structure

- `main.go`: Go application entry point.
- `Dockerfile`: Multistage build instructions.
- `go.mod`: Go module definition.
