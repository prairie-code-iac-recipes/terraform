FROM ubuntu:19.10
LABEL maintainer="The Salte Team <admin@salte.io>"

# Various CI/CD Dependencies
RUN apt-get update && \
    apt-get install -y curl gnupg jq openssl ssh zip && \
    apt-get clean

# Terraform
RUN curl -o /tmp/terraform.zip https://releases.hashicorp.com/terraform/0.12.7/terraform_0.12.7_linux_amd64.zip && \
    unzip /tmp/terraform.zip -d /usr/local/bin && \
    rm /tmp/terraform.zip

# Microsoft SQL Server Tools
ENV ACCEPT_EULA=Y

RUN curl -s -N https://packages.microsoft.com/keys/microsoft.asc | apt-key add - && \
    curl https://packages.microsoft.com/config/ubuntu/16.04/prod.list | tee /etc/apt/sources.list.d/msprod.list && \
    apt-get update && \
    apt-get install -y mssql-tools unixodbc-dev && \
    apt-get install -y locales && \
    echo "en_US.UTF-8 UTF-8" > /etc/locale.gen && \
    locale-gen

# FlywayDB Database Migration Tool
RUN curl -o /tmp/flyway.tar.gz https://repo1.maven.org/maven2/org/flywaydb/flyway-commandline/6.0.1/flyway-commandline-6.0.1-linux-x64.tar.gz && \
    tar -xvzf /tmp/flyway.tar.gz --directory /opt && \
    ln -s /opt/flyway-6.0.1/flyway /usr/local/bin

# AWS CLI
ENV AWS_CLI_VERSION=1.16.185

RUN apt-get install -y python python-pip git groff less && \
    pip install --no-cache-dir awscli==$AWS_CLI_VERSION

ENV PATH /opt/mssql-tools/bin:$PATH

ENTRYPOINT ["terraform"]
