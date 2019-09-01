FROM ubuntu:19.10
LABEL maintainer="The Salte Team <admin@salte.io>"

ENV ACCEPT_EULA=Y

RUN apt-get update && \
    apt-get install -y curl gnupg jq openssl zip && \
    apt-get clean && \
    curl -o /tmp/terraform.zip https://releases.hashicorp.com/terraform/0.12.7/terraform_0.12.7_linux_amd64.zip && \
    unzip /tmp/terraform.zip -d /usr/local/bin && \
    rm /tmp/terraform.zip && \
    curl -s -N https://packages.microsoft.com/keys/microsoft.asc | apt-key add - && \
    curl https://packages.microsoft.com/config/ubuntu/16.04/prod.list | tee /etc/apt/sources.list.d/msprod.list && \
    apt-get update && \
    apt-get install -y mssql-tools unixodbc-dev && \
    apt-get install -y locales && \
    echo "en_US.UTF-8 UTF-8" > /etc/locale.gen && \
    locale-gen


ENV PATH /opt/mssql-tools/bin:$PATH

ENTRYPOINT ["terraform"]
