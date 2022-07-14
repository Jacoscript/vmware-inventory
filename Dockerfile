FROM ubuntu:22.04
ENV DEBIAN_FRONTEND=noninteractive
RUN apt update; \
    apt install wget -y; \
    wget -O ms.deb https://packages.microsoft.com/config/ubuntu/22.04/packages-microsoft-prod.deb; \
    apt install ./ms.deb; \
    apt update; \
    apt install powershell -y
CMD [ "pwsh" ]