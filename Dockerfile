FROM ubuntu:22.04
ENV DEBIAN_FRONTEND=noninteractive
RUN apt update; \
    apt install wget -y python3 python3-pip; \
    wget -O ms.deb https://packages.microsoft.com/config/ubuntu/22.04/packages-microsoft-prod.deb; \
    apt install ./ms.deb; \
    apt update; \
    apt install powershell -y
RUN pip3 install openpyxl; \
    pwsh -c "Install-Module -Name VMware.PowerCLI -Force -WarningAction SilentlyContinue"; \
    pwsh -c "Install-Module -Name PSWriteOffice -Force -WarningAction SilentlyContinue"; \
    pwsh -c "Set-PowerCLIConfiguration -InvalidCertificateAction Ignore -Confirm:\$false -WarningAction SilentlyContinue"
CMD [ "pwsh" ]