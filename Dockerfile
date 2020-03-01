ARG NOTEBOOK_BASE=jupyter/all-spark-notebook
FROM $NOTEBOOK_BASE
# switch to root so we can install .net sdk
USER root
ENV \
    # Enable detection of running in a container
    DOTNET_RUNNING_IN_CONTAINER=true \
    # Enable correct mode for dotnet watch (only mode supported in a container)
    DOTNET_USE_POLLING_FILE_WATCHER=true \
    # Skip extraction of XML docs - generally not useful within an image/container - helps performance
    NUGET_XMLDOC_MODE=skip \
    # PowerShell telemetry for docker image usage
    POWERSHELL_DISTRIBUTION_CHANNEL=PSDocker-DotnetCoreSDK-Ubuntu-18.04

# Register Microsoft key and feed
RUN wget -q https://packages.microsoft.com/config/ubuntu/18.04/packages-microsoft-prod.deb \
		-O packages-microsoft-prod.deb \ 
	&& sudo dpkg -i packages-microsoft-prod.deb \
	&& rm packages-microsoft-prod.deb

# Install the .NET Core SDK
RUN sudo apt-get update \
	&& sudo apt-get install -y dotnet-sdk-3.1 \
	# Trigger first run experience by running arbitrary cmd
	&& dotnet help \
    # Cleanup apt-get
    && rm -rf /var/lib/apt/lists/*

# Install the .NET interactive global tool
RUN dotnet tool install -g dotnet-try

# https://github.com/dotnet/try/issues/645 - deal with .NET globals not showing up for tools
ENV PATH="${PATH}:${HOME}/.dotnet/tools"

# Install the jupyter kernel for .NET
RUN dotnet try jupyter install

# switch back to jupyter notebooks user
USER "jovyan"
ENTRYPOINT [ "/usr/bin/tini", "--" ]
CMD [ "/bin/bash" ]