ARG BUILD_FROM=ghcr.io/home-assistant/base:latest
FROM ${BUILD_FROM}

ARG BUILD_VERSION
ARG BUILD_ARCH
ARG MAILPIT_VERSION=v1.29.7

RUN apk add --no-cache ca-certificates curl tar

RUN case "${BUILD_ARCH}" in \
      amd64) MAILPIT_ARCH=amd64 ;; \
      aarch64) MAILPIT_ARCH=arm64 ;; \
      i386) MAILPIT_ARCH=386 ;; \
      *) echo "Unsupported architecture: ${BUILD_ARCH}" && exit 1 ;; \
    esac \
    && curl -fsSL -o /tmp/mailpit.tar.gz "https://github.com/axllent/mailpit/releases/download/${MAILPIT_VERSION}/mailpit-linux-${MAILPIT_ARCH}.tar.gz" \
    && tar -xzf /tmp/mailpit.tar.gz -C /usr/local/bin \
    && chmod 0755 /usr/local/bin/mailpit \
    && rm -f /tmp/mailpit.tar.gz

COPY run.sh /run.sh
RUN chmod a+x /run.sh

LABEL \
  io.hass.version="${BUILD_VERSION}" \
  io.hass.type="addon" \
  io.hass.arch="${BUILD_ARCH}"

CMD ["/run.sh"]
