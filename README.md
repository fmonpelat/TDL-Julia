# TDL-Julia
75.31 - Teoria del Lenguaje FIUBA

![Docker build/push lead image](https://github.com/fmonpelat/TDL-Julia/workflows/Docker%20build/push%20lead%20image/badge.svg?branch=master)

![Docker build/push worker image](https://github.com/fmonpelat/TDL-Julia/workflows/Docker%20build/push%20worker%20image/badge.svg?branch=master)

# Proyecto Integrador
Lenguaje: Julia

# Introduccion
--

# Docker
## Getting Started

These instructions will cover usage information and for the docker container 

### Prerequisities

In order to run this container you'll need docker installed.

* [Windows](https://docs.docker.com/windows/started)
* [OS X](https://docs.docker.com/mac/started/)
* [Linux](https://docs.docker.com/linux/started/)

## Deployment
--
Begin build and deploy with compose:
```docker-compose -f docker-compose.yml up --build -d```

to access to the lead hostname shell:
```ssh -p 2022 -o "UserKnownHostsFile=/dev/null" -o "StrictHostKeyChecking=no" root@localhost```
### Container Credentials

User:root Pass:123456

User:montecarlo (access to workers by publickey)
