FROM debian:bookworm

LABEL build_version="2024-03-04.0"

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
chmod 400 /root/.ssh/authorized_keys && \
curl -L https://github.com/docker/compose/releases/download/v2.24.6/docker-compose-linux-x86_64 -o /usr/local/bin/docker-compose && \
chmod +x /usr/local/bin/docker-compose && \
if ! [ -d /root/.config/fish ]; then mkdir -p /root/.config/fish ; fi && \
echo abbr -a dc docker compose -f /docker/docker-compose.yml | tee -a /root/.config/fish/config.fish

COPY --from=docker:dind /usr/local/bin/docker /usr/local/bin/

EXPOSE 22

CMD ["/bin/bash", "-c", "echo \"$SSH_PUBLIC_KEY\" > /root/.ssh/authorized_keys; /usr/sbin/sshd -D"]
