############# builder
FROM golang:1.16.2 AS builder

WORKDIR /go/src/github.com/23technologies/gardener-extension-os-k3os
COPY . .
RUN make install-requirements && make generate && make install

############# gardener-extension-os-k3os
FROM alpine:3.13.5 AS gardener-extension-os-k3os

COPY --from=builder /go/bin/gardener-extension-os-k3os /gardener-extension-os-k3os
ENTRYPOINT ["/gardener-extension-os-k3os"]
