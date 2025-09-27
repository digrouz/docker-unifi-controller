# docker-unifi-controller

[![auto-update-workflow](https://github.com/digrouz/docker-unifi-controller/actions/workflows/auto-update.yml/badge.svg)](https://github.com/digrouz/docker-unifi-controller/actions/workflows/auto-update.yml)
[![dockerhub-workflow](https://github.com/digrouz/docker-unifi-controller/actions/workflows/dockerhub.yml/badge.svg)](https://github.com/digrouz/docker-unifi-controller/actions/workflows/dockerhub.yml)
![Docker Pulls](https://img.shields.io/docker/pulls/ndgconsulting/unifi-controller)

Install Unifi Controller into a Linux container

![unifi-controller](https://assets-global.website-files.com/622b70d8906c7ab0c03f77f8/63b40a92093c6b2f3767e4e6_tMCv8T-y_400x400.png)

## Tag

Several tag are available:

* latest: see debian
* debian: [Dockerfile_debian](https://github.com/digrouz/docker-unifi-controller/blob/master/Dockerfile_debian)

## Description

Remotely monitor and manage UniFi Network devices

[https://www.ui.com/download/unifi/](https://www.ui.com/download/unifi/)

## Usage

    docker create --name=unifi-controller  \
      -v <path to config>:/config   \
      -e UID=<UID default:12345> \
      -e GID=<GID default:12345> \
      -e AUTOUPGRADE=<0|1 default:0> \
      -e TZ=<timezone default:Europe/Brussels> \
      -e XMS=<memory default:256> \
      -e XMX=<memory default:1024> \
      -p 8080:8080 \
      -p 8443:8443 \
      -p 8843:8843 \
      -p 8880:8880 \
      -p 3478:3478/udp \
      -p 1900:1900/udp \
      -p 10001:10001/udp \
    ndgconsulting/unifi-controller:latest

## Environment Variables

When you start the `unifi-controller` image, you can adjust the configuration of the `unifi-controller` instance by passing one or more environment variables on the `docker run` command line.

### `UID`

This variable is not mandatory and specifies the user id that will be set to run the application. It has default value `12345`.

### `GID`

This variable is not mandatory and specifies the group id that will be set to run the application. It has default value `12345`.

### `AUTOUPGRADE`

This variable is not mandatory and specifies if the container has to launch software update at startup or not. Valid values are `0` and `1`. It has default value `0`.

### `TZ`

This variable is not mandatory and specifies the timezone to be configured within the container. It has default value `Europe/Brussels`.

### `XMS`

This variable is not mandatory and specifies the starting memory alocated to the java jvm. It has default value `256`.

### `XMX`

This variable is not mandatory and specifies the maximum memory alocated to the java jvm. It has default value `1024`.

## Notes

* This container is built using [s6-overlay](https://github.com/just-containers/s6-overlay)
* The docker entrypoint can upgrade operating system at each startup. To enable this feature, just add `-e AUTOUPGRADE=1` at container creation.
* An helm chart is available of in the [chart folder](https://github.com/digrouz/docker-unifi-controller/tree/master/chart) with an example [value.yaml](https://github.com/digrouz/docker-unifi-controller/tree/master/chart/value.yaml)
* Port used for device and application communication: `8080` 
* Port used for application GUI/API as seen in a web browser: `8443`
* Port used for HTTP portal redirection: `8880`
* Port used for HTTPS portal redirection: `8843`
* Port used for STUN Unifi: `3478/UDP`
* Port used for AP Discovery: `10001/UDP`
* Port used for Network Layer 2 Discovery: `1900/UDP`

## Issues

If you encounter an issue please open a ticket at [github](https://github.com/digrouz/docker-unifi-controller/issues)
