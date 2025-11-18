# Given build
# I'm not going to make you all fight with compiling go
FROM golang:1.22-alpine AS builder
WORKDIR /app
COPY go.mod ./
RUN go mod download
COPY . .
RUN go build -o server .

# Step 2: Run
FROM alpine:3.20
WORKDIR /app
COPY --from=builder /app/server /app/server
EXPOSE 8080
CMD ["./server"]
# TODO: 
    # set WORKDIR to the /app directory
    # copy our current directory to /app/server (hint - use --from=builder)
    # expose port 8080 
    # run our server using CMD and ./server
