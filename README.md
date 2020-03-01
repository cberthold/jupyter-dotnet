[![docker pulls](https://img.shields.io/docker/pulls/cberthold/jupyter-dotnet.svg)](https://hub.docker.com/r/cberthold/jupyter-dotnet/) [![docker stars](https://img.shields.io/docker/stars/cberthold/jupyter-dotnet.svg)](https://hub.docker.com/r/cberthold/jupyter-dotnet/) [![image metadata](https://images.microbadger.com/badges/image/cberthold/jupyter-dotnet.svg)](https://microbadger.com/images/cberthold/jupyter-dotnet "cberthold/jupyter-dotnet image metadata")

# Jupyter notebooks with .NET Interactive
Jupyter notebooks with .NET Interactive is a ready-to-run [Docker image](https://hub.docker.com/r/cberthold/jupyter-dotnet) plus some commands to help you get up and running quickly with Jupyter Labs / Notebook and .NET Interactive already installed.  It's purpose is to allow you to build Jupyter Notebooks with .NET code in them.  It's also inspired to create a Notebook-as-Code NaC possibility (needs work).

## Things it does
 - Runs Jupyter Notebooks with the all-spark-notebook image as its base
 - Runs the .Net Jupyter Kernel
 - Allows you to run C# Notebooks
 - Allows you to run F# Notebooks
 - Saves notebooks that are in the `/work` folder in the container to the `/code` folder in your path that you run it from.

## Things to do
 - Figure out how to separate the scripts from code directory (gitlab extension?)
 - Prove out how to save notebooks as part of a development process
 - Figure out how to perhaps make intalling other extensions as part of the startup process

## Quick Start

Currently these steps have only been tested on Mac OS X.  They likely will work with Linux too.  You must have *Docker* already installed.  You must have *jq* installed.

### Install *jq*
```
brew install jq
```

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
- [Jupyter Issue Tracker on GitHub](https://github.com/jupyter/docker-stacks/issues)
- [Jupyter .NET Issue Tracker on GitHub](https://github.com/cberthold/jupyter-dotnet/issues)
- [Jupyter Website](https://jupyter.org)
- [Images on DockerHub](https://hub.docker.com/r/cberthold/jupyter-dotnet)


