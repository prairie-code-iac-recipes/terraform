FROM debian:stretch
LABEL maintainer="The Salte Team <admin@salte.io>"

RUN apt-get update && \
    apt-get install -y curl jq openssl zip && \
    apt-get clean && \
    curl -o /tmp/terraform.zip https://releases.hashicorp.com/terraform/0.12.7/terraform_0.12.7_linux_amd64.zip && \
    unzip /tmp/terraform.zip -d /usr/local/bin && \
    rm /tmp/terraform.zip

ENTRYPOINT ["terraform"]
