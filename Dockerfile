FROM golang:latest
WORKDIR /go/src/github.com/google/huproxy
COPY . .
RUN mkdir /app
RUN go mod download
RUN CGO_ENABLED=0 GOOS=linux go build -a -o /app ./cmd/huproxy
RUN CGO_ENABLED=0 GOOS=linux go build -a -o /app ./cmd/huproxyclient

FROM alpine:latest
EXPOSE 8086
WORKDIR /
COPY --from=0 /app/ .
ENTRYPOINT ["/huproxy"]
