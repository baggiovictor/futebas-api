# build stage
FROM golang:1.23-alpine AS build

WORKDIR /app

COPY . .

RUN go mod download

RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -o ./bin/futebas ./cmd/http/main.go

FROM alpine:latest AS final


WORKDIR /app

COPY --from=build /app/bin/futebas ./

EXPOSE 8080

ENTRYPOINT [ "./futebas" ]