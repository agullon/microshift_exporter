FROM registry.access.redhat.com/ubi9/go-toolset:latest as builder
WORKDIR /app
RUN go mod init microshift-exporter
RUN go get github.com/prometheus/client_golang/prometheus
RUN go get github.com/prometheus/client_golang/prometheus/promhttp
COPY microshift-exporter.go collect-metrics.go /app/
RUN CGO_ENABLED=0 GOOS=linux go build /app/

FROM registry.access.redhat.com/ubi9/ubi-micro:latest
WORKDIR /
COPY --from=builder /app/microshift-exporter /microshift-exporter
ENV PORT 9090
CMD ["/microshift-exporter"]
