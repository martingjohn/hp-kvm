# hp-kvm
As the card software for the HP Microserver GEN 6 remote access card is rather old, it only seems to work with Java 1.6, which is rather hard to get working now without something like an Windows XP virtual machine.

This provides access to either the KVM console or the media manager via a Ubuntu 12.04 docker image and vnc client

To run to get access to the KVM console

    docker run \
       -d \
       --name kvm \
       --rm \
       -p 5902:5902 \
       -e KVM_HOST=microserver \
       -e KVM_USER=admin \
       -e KVM_PASSWORD=secret \
       -e KVM_DOMAIN=home \
       -e KVM_SCRIPT=kvm \
       -e VNC_PORT=5902 \
       -e VNC_PASSWORD=secret \
       -e VNC_RESOLUTION=800x600 \
       martinjohn/hp-kvm

To get access to the media manager

    docker run \
       -d \
       --name media \
       --rm \
       -p 5902:5902 \
       -e KVM_HOST=microserver \
       -e KVM_USER=admin \
       -e KVM_PASSWORD=secret \
       -e KVM_DOMAIN=home \
       -e KVM_SCRIPT=media \
       -e VNC_PORT=5902 \
       -e VNC_PASSWORD=secret \
       -e VNC_RESOLUTION=800x600 \
       martinjohn/hp-kvm

Obviously you need to either pass through the port or run on the host network.

Variables defined are

KVM_HOST - hostname of the Microserver (this could be fully qualified or you can fill in the KVM_DOMAIN) (default: default)
KVM_USER - username you log into the Microserver's remote access card webpage with (default: admin)
KVM_PASSWORD - password you log into the Microserver's remote access card webpage with (default: secret)
KVM_DOMAIN - used with the KVM_HOST and a nslookup to find the FQDN of the Microserver (default: home)
KVM_SCRIPT - either kvm or media, depending on what you want to run (default: kvm)
VNC_PORT - port for VNC to run on, needs to match with the "-p" settings (default: 5900)
VNC_PASSWORD - password for VNC server or "" for none (default: no password)
VNC_RESOLUTION - resolution for the VNC server in format HxV (default: 800x600)
