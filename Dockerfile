FROM golang:1.23-alpine AS builder

WORKDIR /app

RUN apk add --no-cache git nodejs npm && \
    git config --global user.email "dev@example.com" && \
    git config --global user.name "dev"

COPY go.mod go.sum ./
RUN go mod download

COPY . .

RUN git init && git add -A && git commit -m "init" || true

RUN npm install && npm run build && \
    CGO_ENABLED=0 go build -o opengist ./cmd/opengist/main.go

FROM alpine:latest

WORKDIR /app

RUN apk add --no-cache git openssh

COPY --from=builder /app/opengist ./opengist
COPY --from=builder /app/public ./public
COPY --from=builder /app/templates ./templates

RUN mkdir -p /opengist

ENV OPENGIST_HOME=/opengist

EXPOSE 6157

CMD ["./opengist", "--config", "/opengist/config.yml"]
