#FROM golang:1.22-alpine as builder
FROM golang:1.23-alpine3.19 AS builder

ADD . /go-iiif

# config (config.json, instructions.json)
RUN mkdir /etc/go-iiif
COPY ./cfg/etc/config_docker.json /etc/go-iiif/config.json
COPY ./cfg/etc/instructions.json /etc/go-iiif/instructions.json

# images
RUN mkdir -p /usr/local/go-iiif

# binary (iiif-server)
RUN mkdir -p /go-iiif/bin/

RUN apk update \
    && apk upgrade \
    && apk add make  \
    && cd /go-iiif \
    && make cli \
    && go install github.com/go-delve/delve/cmd/dlv@latest

# Copy binary from build to main folder
RUN cp /go-iiif/bin/* . 



VOLUME /etc/go-iiif
VOLUME /usr/local/go-iiif

#EXPOSE 40000 8080 2345
EXPOSE 8080 2345

#CMD ["dlv", "debug", "--headless", "--listen=:40000", "--api-version=2", "--accept-multiclient", "--log"]
# CMD ["/go/run.sh"]


# FROM alpine
# FROM alpine:3.19

# RUN mkdir /etc/go-iiif
# RUN mkdir -p /usr/local/go-iiif

# COPY ./cfg/etc/config_docker.json /etc/go-iiif/config.json
# COPY ./cfg/etc/instructions.json /etc/go-iiif/instructions.json

# COPY --from=builder /go-iiif/bin/iiif-process /bin/iiif-process
# COPY --from=builder /go-iiif/bin/iiif-server /bin/iiif-server
# COPY --from=builder /go-iiif/bin/iiif-tile-seed /bin/iiif-tile-seed
# COPY --from=builder /go/pkg/mod/github.com/go-delve/ /go/pkg/mod/github.com/go-delve/

# RUN apk update \
#     && apk upgrade \
#     && apk add \    
# #    zlib libxml2 glib gobject-introspection \
# #    libjpeg-turbo libexif lcms2 fftw giflib libpng \
# #    libwebp orc tiff poppler-glib librsvg libgsf openexr \
#     ca-certificates

# VOLUME /etc/go-iiif
# VOLUME /usr/local/go-iiif

