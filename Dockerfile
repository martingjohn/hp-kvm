FROM ubuntu:12.04

ENV KVM_HOST=default \
    KVM_USER=admin \
    KVM_PASSWORD=secret \
    KVM_DOMAIN=home \
    KVM_SCRIPT=kvm \
    VNC_PORT=5900 \
    VNC_PASSWORD="" \
    VNC_RESOLUTION=800x600

RUN apt-get update \
 && DEBIAN_FRONTEND=noninteractive \
    apt-get install -y \
            --no-install-recommends \
            icedtea-netx \
            dnsutils \
            openjdk-6-jre \ 
            x11vnc \
            xvfb \
 && rm -rf /var/lib/apt/lists/*

WORKDIR /opt

ADD kvm.sh /opt/kvm.sh
ADD media.sh /opt/media.sh
ADD entrypoint.sh /opt/entrypoint.sh

ENTRYPOINT ["/opt/entrypoint.sh"]

