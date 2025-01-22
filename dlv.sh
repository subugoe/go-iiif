#!/bin/sh
##(cd /go-iiif/bin && dlv --listen=:40000 --headless=true exec ./iiif-server -- -host 0.0.0.0 -config-source file:///etc/go-iiif)
dlv --listen=:2345 --headless=true --log=true --log-output=debugger,debuglineerr,gdbwire,lldbout,rpc --accept-multiclient --api-version=2 exec /go/iiif-server -- -host 0.0.0.0 -config-source file:///etc/iiif-server/
##(cd /bin && dlv --listen=:40000 --headless=true exec ./iiif-server -- -host 0.0.0.0 -config-source file:///etc/go-iiif)