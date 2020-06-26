FROM julia:1.4.2-buster

RUN apt-get update && apt-get -y install openssh-server ssh git
RUN groupadd sshgroup && useradd -ms /bin/bash -g sshgroup sshuser

# SSH configuration
RUN mkdir /var/run/sshd && \
    sed -ri 's/^#?PermitRootLogin\s+.*/PermitRootLogin yes/' /etc/ssh/sshd_config && \
    sed -ri 's/UsePAM yes/#UsePAM yes/g' /etc/ssh/sshd_config && \
    mkdir /root/.ssh
COPY ./sshd_config /etc/ssh/sshd_config
# Setup ssh root access
RUN echo 'root:123456' | chpasswd

# change hostname prompt on terminal console
#RUN printf "%s\n" "export PS1=\"[\u@$HOSTNAME] \W # \"" >> /root/.bash_profile

# add git coloring on git repos
RUN echo "parse_git_branch() { " >> /root/.bash_profile && \
    printf "%s\n" "  git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'" >> /root/.bash_profile && \
    echo "}" >> /root/.bash_profile && \
    printf "%s\n" "export PS1=\"\u@\h \W\[\033[32m\]\\\$(parse_git_branch)\[\033[00m\] \$ \"" >> /root/.bash_profile && \
    echo "alias ll='ls -latr'" >> /root/.bash_profile

RUN echo "parse_git_branch() { " >> /home/sshuser/.bash_profile && \
    printf "%s\n" "  git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'" >> /home/sshuser/.bash_profile && \
    echo "}" >> /home/sshuser/.bash_profile && \
    printf "%s\n" "export PS1=\"\u@\h \W\[\033[32m\]\\\$(parse_git_branch)\[\033[00m\] \$ \"" >> /home/sshuser/.bash_profile && \
    echo "alias ll='ls -latr'" >> /home/sshuser/.bash_profile

#remove leftovers of apt
RUN rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Setting up worker public keys
ARG home=/home/sshuser
RUN mkdir $home/.ssh
COPY ./.ssh-lead/id_rsa.pub $home/.ssh/authorized_keys
RUN chown sshuser:sshgroup $home/.ssh/authorized_keys && \
    chmod 600 $home/.ssh/authorized_keys

# Expose ssh port to containers
EXPOSE 22

CMD ["/usr/sbin/sshd", "-D"]
