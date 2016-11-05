FROM microsoft/windowsservercore

SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop';"]

# download and install chocolatey
RUN $env:chocolateyUseWindowsCompression = 'false'; \
    Invoke-WebRequest -Uri 'https://chocolatey.org/install.ps1' -UseBasicParsing -Verbose | Invoke-Expression -Verbose;

# install git
RUN choco install git -y;

# install python2
ENV PYTHONIOENCODING="UTF-8"
RUN choco install python2 -y;
RUN python -m pip install -U pip;
RUN [Environment]::SetEnvironmentVariable('Path', $env:Path + ';C:\tools\python2\Scripts', [EnvironmentVariableTarget]::Machine);
RUN pip install --no-cache-dir virtualenv
