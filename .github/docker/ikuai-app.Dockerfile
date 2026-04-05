# syntax=docker/dockerfile:1.7

FROM alpine:3.21

COPY --chmod=0755 fileuni /usr/local/bin/fileuni

ENTRYPOINT ["/usr/local/bin/fileuni"]
