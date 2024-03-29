# docker-yoctobuilder
yocto build environment based on ubuntu 22.04

[![yoctobuilder build](https://github.com/prashantdivate/docker-yoctobuilder/actions/workflows/publish-image.yml/badge.svg)](https://github.com/prashantdivate/docker-yoctobuilder/actions/workflows/publish-image.yml)

## How to use

```
docker run -it --rm \
    -v $PWD:/home/worker/building \
    -v $HOME/.ssh:/home/worker/.ssh \
    ghcr.io/prashantdivate/yoctobuilder:latest
```

available tags: `latest`


## How to build

```
docker buildx build . -t ghcr.io/prashantdivate/yoctobuilder:<tag>
```
