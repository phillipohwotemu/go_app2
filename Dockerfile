# Use the official Golang image to create a build artifact.
# This is based on Debian and sets the GOPATH to /go.
FROM golang:1.18 as builder

# Set the Current Working Directory inside the container
WORKDIR /app

# Initialize a new module (only necessary if your repo doesn't include a go.mod file)
# You can replace 'example.com/mymodule' with your module's path or any name you choose
RUN go mod init example.com/mymodule

# Copy local code to the container image.
COPY . .

# Build the command inside the container.
RUN go build -v -o myGoApp

# Use the official Debian slim image for a lean production container.
FROM debian:buster-slim
COPY --from=builder /app/myGoApp /myGoApp

# Run the web service on container startup.
CMD ["/myGoApp"]

