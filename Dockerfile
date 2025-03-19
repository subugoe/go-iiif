FROM golang:1.23-alpine3.20 AS builder

ADD . /go-iiif

# config (config.json, instructions.json)
RUN mkdir /etc/go-iiif

# images
RUN mkdir -p /usr/local/go-iiif

# binary (iiif-server)
RUN mkdir -p /go-iiif/bin/

RUN apk update \
    && apk upgrade \
    && apk add make curl  \
    && cd /go-iiif \
    && make cli \
    && go install github.com/go-delve/delve/cmd/dlv@latest

# Copy binary from build to main folder
RUN cp /go-iiif/bin/* . 


FROM alpine:3.20

# RUN mkdir /etc/go-iiif
# RUN mkdir -p /usr/local/go-iiif

COPY ./cfg/etc/config.json /etc/go-iiif/config.json
COPY ./cfg/etc/instructions.json /etc/go-iiif/instructions.json

#COPY --from=builder /go-iiif/bin/iiif-process /bin/iiif-process
COPY --from=builder /go/iiif-server /go/iiif-server
#COPY --from=builder /go-iiif/bin/iiif-tile-seed /bin/iiif-tile-seed
COPY --from=builder /go/pkg/mod/github.com/go-delve/ /go/pkg/mod/github.com/go-delve/

RUN apk update \
     && apk upgrade \
     && apk add \    
     zlib libxml2 glib gobject-introspection \
     libjpeg-turbo libexif lcms2 fftw giflib libpng \
     libwebp orc tiff poppler-glib librsvg libgsf openexr \
     ca-certificates

# VOLUME /etc/go-iiif
# VOLUME /usr/local/go-iiif

