FROM registry.ci.openshift.org/ocp/builder:rhel-8-golang-1.15-openshift-4.6 AS builder
WORKDIR /go/src/github.com/openshift/mdns-publisher
COPY . .
RUN GO111MODULE=on go build --mod=vendor

FROM registry.ci.openshift.org/ocp/4.6:base
COPY --from=builder /go/src/github.com/openshift/mdns-publisher/mdns-publisher /usr/bin/

ENTRYPOINT ["/usr/bin/mdns-publisher"]

LABEL io.k8s.display-name="mDNS-publisher" \
      io.k8s.description="Configurable mDNS service publisher" \
      maintainer="Antoni Segura Puimedon <antoni@redhat.com>"
