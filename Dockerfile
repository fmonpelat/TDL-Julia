FROM julia:1.4.2-buster
#FROM julia:1.3

RUN apt-get update && apt-get -y install openssh-server ssh git vim python3 curl
# Working username project
ARG username=montecarlo
ARG home=/home/$username
RUN groupadd $username && useradd -ms /bin/bash -g $username $username

# SSH configuration
RUN mkdir /var/run/sshd && \
    mkdir /root/.ssh
COPY ./sshd_config /etc/ssh/sshd_config

# Setup ssh root access
RUN echo 'root:123456' | chpasswd

# Add git coloring on git repos PS1 and aliases
RUN echo "parse_git_branch() { " >> /root/.bash_profile && \
    printf "%s\n" "  git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'" >> /root/.bash_profile && \
    echo "}" >> /root/.bash_profile && \
    printf "%s\n" "export PS1=\"\u@\h \W\[\033[32m\]\\\$(parse_git_branch)\[\033[00m\] \$ \"" >> /root/.bash_profile && \
    echo "alias ll='ls -latr'" >> /root/.bash_profile && \
    echo "alias julia='/usr/local/julia/bin/julia'" >> /root/.bash_profile

RUN echo "parse_git_branch() { " >> $home/.bash_profile && \
    printf "%s\n" "  git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'" >> $home/.bash_profile && \
    echo "}" >> $home/.bash_profile && \
    printf "%s\n" "export PS1=\"\u@\h \W\[\033[32m\]\\\$(parse_git_branch)\[\033[00m\] \$ \"" >> $home/.bash_profile && \
    echo "alias ll='ls -latr'" >> $home/.bash_profile && \
    echo "alias julia='/usr/local/julia/bin/julia'" >> $home/.bash_profile

# Disable on workers fingerprint host checking
RUN printf "%s\n    %s\n    %s" "Host worker_*" "StrictHostKeyChecking no" "UserKnownHostsFile=/dev/null" >> /etc/ssh/ssh_config

# Remove leftovers of apt
RUN rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# copy of ssh keys
RUN mkdir $home/.ssh
COPY ./.ssh-lead/id_rsa.pub $home/.ssh/authorized_keys
COPY ./.ssh-lead/id_rsa.pub /root/.ssh/authorized_keys
RUN chown $username:$username $home/.ssh/authorized_keys && \
    chmod 600 $home/.ssh/authorized_keys
    
# Working directory
WORKDIR /home/montecarlo/workdir

# Expose ssh port to containers
EXPOSE 22


CMD ["/usr/sbin/sshd", "-D"]
