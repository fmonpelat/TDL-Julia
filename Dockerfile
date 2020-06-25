FROM julia:1.4.2-buster

RUN apt-get update && apt-get -y install openssh-server ssh
RUN groupadd sshgroup && useradd -ms /bin/bash -g sshgroup sshuser
RUN mkdir /var/run/sshd

COPY ./sshd_config /etc/ssh/sshd_config

ARG home=/home/sshuser
RUN mkdir $home/.ssh
COPY ./.ssh-lead/id_rsa.pub $home/.ssh/authorized_keys
RUN chown sshuser:sshgroup $home/.ssh/authorized_keys && \
    chmod 600 $home/.ssh/authorized_keys

EXPOSE 22
CMD ["/usr/sbin/sshd", "-D"]
