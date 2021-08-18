FROM ubuntu:20.04

ENV DEBIAN_FRONTEND=noninteractive
ENV container=docker LANG=C.UTF-8

# Enable all repositories.
RUN sed -i 's/# deb/deb/g' /etc/apt/sources.list

RUN apt-get update && \
    apt-get install --no-install-recommends -y \
    software-properties-common dbus systemd systemd-cron rsyslog iproute2 python python-apt sudo bash ca-certificates \
    curl net-tools jq unzip vim dnsutils iputils-ping socat && \
    apt-get clean && \
    rm -rf /usr/share/doc/* /usr/share/man/* /var/lib/apt/lists/* /tmp/* /var/tmp/*


RUN sed -i 's/^\(module(load="imklog")\)/#\1/' /etc/rsyslog.conf

# Only start the services we need.
RUN find /etc/systemd/system \
    /lib/systemd/system \
    -path '*.wants/*' \
    -not -name '*dbus*' \
    -not -name '*journald*' \
    -not -name '*systemd-tmpfiles*' \
    -not -name '*systemd-user-sessions*' \
    -exec rm \{} \;

RUN systemctl set-default multi-user.target
RUN systemctl mask dev-hugepages.mount sys-fs-fuse-connections.mount

# Hack to make sure that logs are written to the right place.
RUN rm -f /usr/sbin/init
ADD init-console /usr/sbin/init
RUN chmod a+x /usr/sbin/init
ENV container docker

# Add systemd unit to write journalctl logs to stdout for debugging
ADD journald-to-log.service /etc/systemd/system/journald-to-log.service
RUN systemctl enable /etc/systemd/system/journald-to-log.service

VOLUME ["/sys/fs/cgroup", "/tmp", "/run", "/run/lock"]
STOPSIGNAL SIGRTMIN+3

CMD ["/sbin/init", "--log-target=journal"]