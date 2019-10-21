FROM i386/ubuntu:14.04

ENV KVM_HOST=default \
    KVM_USER=admin \
    KVM_PASSWORD=secret \
    KVM_DOMAIN=home \
    KVM_SCRIPT=kvm \
    VNC_PORT=5900 \
    VNC_PASSWORD="" \
    VNC_RESOLUTION=800x600 \
    KEYMAP="us"

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

RUN update-alternatives --set javaws /usr/lib/jvm/java-6-openjdk-i386/jre/bin/javaws

WORKDIR /opt

COPY kvm.sh /opt/kvm.sh
COPY media.sh /opt/media.sh
COPY entrypoint.sh /opt/entrypoint.sh

ENTRYPOINT ["/opt/entrypoint.sh"]
