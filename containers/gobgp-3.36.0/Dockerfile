FROM docker.io/ubuntu:24.04 AS base
LABEL maintainer="Marcel Fest"

ARG DEBIAN_FRONTEND=noninteractive

# Install: dependencies, clean: apt cache, remove dir: cache, man, doc, change mod time of cache dir.
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
       software-properties-common ca-certificates \
       wget \
       systemd \
       netplan.io \
       mtr-tiny \
       dnsutils \
       bridge-utils \
       conntrack \
       ethtool \
       iftop \
       iperf \
       iputils-ping \
       iputils-arping \
       nmap \
       socat \
       tcpdump \
       tcptraceroute \
       vim

COPY entrypoint.sh /bin/entrypoint.sh
RUN chmod +x /bin/entrypoint.sh
RUN echo 'root:root' | chpasswd

FROM base

RUN apt-get update -y && apt-get install -y --no-install-recommends \
       gobgpd \
    && apt-get clean \
    && rm -Rf /usr/share/doc && rm -Rf /usr/share/man \
    && rm -rf /var/lib/apt/lists/* \
    && touch -d "2 hours ago" /var/lib/apt/lists

RUN ln -s /lib/systemd/system/systemd-networkd.service /etc/systemd/system/dbus-org.freedesktop.network1.service \
    && ln -s /lib/systemd/system/systemd-networkd.service /etc/systemd/system/multi-user.target.wants/systemd-networkd.service \
    && mkdir -p /etc/systemd/system/sockets.target.wants \
    && ln -s /lib/systemd/system/systemd-networkd.socket /etc/systemd/system/sockets.target.wants/systemd-networkd.socket \
    && ln -s /lib/systemd/system/systemd-network-generator.service /etc/systemd/system/sysinit.target.wants/systemd-network-generator.service \
    && mkdir -p /etc/systemd/system/network-online.target.wants \
    && ln -s /lib/systemd/system/systemd-networkd-wait-online.service /etc/systemd/system/network-online.target.wants/systemd-networkd-wait-online.service

VOLUME ["/sys/fs/cgroup"]
STOPSIGNAL SIGRTMIN+3
CMD ["/bin/entrypoint.sh"]