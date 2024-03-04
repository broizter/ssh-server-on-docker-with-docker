FROM debian:bookworm

RUN apt-get update && apt-get install --no-install-recommends -y openssh-server curl ca-certificates fish && \
usermod -s /usr/bin/fish root && \
rm /etc/motd && \
rm /etc/update-motd.d/10-uname && \
mkdir /var/run/sshd && \
sed -i 's/#PasswordAuthentication yes/PasswordAuthentication no/g' /etc/ssh/sshd_config && \
sed -i 's/X11Forwarding yes/X11Forwarding no/g' /etc/ssh/sshd_config

COPY --from=docker:dind /usr/local/bin/docker /usr/local/bin/

EXPOSE 22

CMD ["/usr/sbin/sshd", "-D"]
