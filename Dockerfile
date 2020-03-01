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
	&& dotnet help

# Install .NET CLI dependencies
#RUN apt-get update \
#    && apt-get install -y --no-install-recommends \
#        libc6 \
#        libgcc1 \
#        libgssapi-krb5-2 \
#        libicu60 \
#        libssl1.1 \
#        libstdc++6 \
#        zlib1g \
#    && rm -rf /var/lib/apt/lists/*

# Install .NET Core SDK
#RUN dotnet_sdk_version=3.1.102 \
#    && curl -SL --output dotnet.tar.gz https://dotnetcli.azureedge.net/dotnet/Sdk/$dotnet_sdk_version/dotnet-sdk-$dotnet_sdk_version-linux-x64.tar.gz \
#    && dotnet_sha512='9cacdc9700468a915e6fa51a3e5539b3519dd35b13e7f9d6c4dd0077e298baac0e50ad1880181df6781ef1dc64a232e9f78ad8e4494022987d12812c4ca15f29' \
#    && echo "$dotnet_sha512 dotnet.tar.gz" | sha512sum -c - \
#    && mkdir -p /usr/share/dotnet \
#    && tar -ozxf dotnet.tar.gz -C /usr/share/dotnet \
#    && rm dotnet.tar.gz \
#    && ln -s /usr/share/dotnet/dotnet /usr/bin/dotnet \
#    # Trigger first run experience by running arbitrary cmd
#    && dotnet help

# Install PowerShell global tool
#RUN powershell_version=7.0.0-rc.2 \
#    && curl -SL --output PowerShell.Linux.x64.$powershell_version.nupkg https://pwshtool.blob.core.windows.net/tool/$powershell_version/PowerShell.Linux.x64.$powershell_version.nupkg \
#    && powershell_sha512='59abcc11bd43fc8c1938a1854447c762092f03b5e2c6c354a82559eed6852e3920c5543c085fbe6fbe98871f96cd7409bb76b1537d3d8dee4e7432d578ec7603' \
#    && echo "$powershell_sha512  PowerShell.Linux.x64.$powershell_version.nupkg" | sha512sum -c - \
#    && mkdir -p /usr/share/powershell \
#    && dotnet tool install --add-source / --tool-path /usr/share/powershell --version $powershell_version PowerShell.Linux.x64 \
#    && dotnet nuget locals all --clear \
#    && rm PowerShell.Linux.x64.$powershell_version.nupkg \
#    && ln -s /usr/share/powershell/pwsh /usr/bin/pwsh \
#    && chmod 755 /usr/share/powershell/pwsh \
#    # To reduce image size, remove the copy nupkg that nuget keeps.
#    && find /usr/share/powershell -print | grep -i '.*[.]nupkg$' | xargs rm

# switch back to jupyter notebooks user
USER "jovyan"
ENTRYPOINT [ "/usr/bin/tini", "--" ]
CMD [ "/bin/bash" ]