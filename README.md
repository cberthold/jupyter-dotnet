[![docker pulls](https://img.shields.io/docker/pulls/cberthold/jupyter-dotnet.svg)](https://hub.docker.com/r/cberthold/jupyter-dotnet/) [![docker stars](https://img.shields.io/docker/stars/cberthold/jupyter-dotnet.svg)](https://hub.docker.com/r/cberthold/jupyter-dotnet/) [![image metadata](https://images.microbadger.com/badges/image/cberthold/jupyter-dotnet.svg)](https://microbadger.com/images/cberthold/jupyter-dotnet "cberthold/jupyter-dotnet image metadata")

# Jupyter notebooks with .NET Interactive
Jupyter notebooks with .NET Interactive is a ready-to-run [Docker image](https://hub.docker.com/r/cberthold/jupyter-dotnet) plus some commands to help you get up and running quickly with Jupyter Labs / Notebook and .NET Interactive already installed.

## Quick Start

Currently these steps have only been tested on Mac OS X.  They likely will work with Linux too.  You must have Docker already installed.

### How to clone
```
git clone https://github.com/cberthold/jupyter-dotnet
cd jupyter-dotnet
```

### How to run from Docker Hub prebuilt image
```
make start
```

### How to open the browser with proper tokens
Note: This will open two tabs
    - A tab for Jupyter Notebooks
    - A tab for Jupyter Lab
```
make open
```

### How to build the image
```
make build
```

### How to run the built image
```
make start-build
```

### How to stop the running image
```
make stop
```

The [Jupyter User Guide on ReadTheDocs](http://jupyter-docker-stacks.readthedocs.io/) describes additional uses and features in detail.

## Resources

- [Jupyter Documentation on ReadTheDocs](http://jupyter-docker-stacks.readthedocs.io/)
- [Issue Tracker on GitHub](https://github.com/jupyter/docker-stacks)
- [Jupyter Website](https://jupyter.org)
- [Images on DockerHub](https://hub.docker.com/r/cberthold/jupyter-dotnet)


