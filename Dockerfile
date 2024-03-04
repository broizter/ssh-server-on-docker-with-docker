FROM debian:bookworm

RUN apt-get update && apt-get install --no-install-recommends -y openssh-server curl ca-certificates fish && \
usermod -s /usr/bin/fish root && \
rm /etc/motd && \
rm /etc/update-motd.d/10-uname && \
mkdir /var/run/sshd && \
sed -i 's/#PasswordAuthentication yes/PasswordAuthentication no/g' /etc/ssh/sshd_config && \
sed -i 's/X11Forwarding yes/X11Forwarding no/g' /etc/ssh/sshd_config && \
if ! [ -d /root/.ssh ]; then mkdir /root/.ssh ; fi && \
if ! [ -f /root/.ssh/authorized_keys ] ; then touch /root/.ssh/authorized_keys ; fi && \
chmod 700 /root/.ssh && \
chmod 400 /root/.ssh/authorized_keys

COPY --from=docker:dind /usr/local/bin/docker /usr/local/bin/

EXPOSE 22

CMD ["/bin/bash", "-c", "echo \"$${SSH_PUBLIC_KEY}\" > /root/.ssh/authorized_keys; /usr/sbin/sshd -D"]
