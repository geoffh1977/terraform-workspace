# Docker Development Container
FROM debian:12-slim

# Variables
ARG DOCKER_VERSION
ARG DOCKER_COMPOSE_VERSION
ARG DOCKER_GROUP_ID
ARG HADOLINT_VERSION
ARG SHELLCHECK_VERSION
ARG USER_GROUP_ID
ARG USER_USER_ID

ENV PYTHONDONTWRITEBYTECODE="1"

SHELL ["/bin/bash", "-o", "pipefail", "-c"]

# Install Packages Needed For Development Environment
# hadolint ignore=DL3008
RUN apt-get update && export DEBIAN_FRONTEND=noninteractive && \
  apt-get -y install --no-install-recommends git gnupg openssh-client bash sudo make xz-utils curl ca-certificates wget \
    pip npm pre-commit jq unzip && \
  apt-get clean && rm -rf /var/lib/apt/lists/*

# Download Docker Binaries Only
RUN wget -q -O - https://download.docker.com/linux/static/stable/x86_64/docker-${DOCKER_VERSION}.tgz | tar -xzvf - --strip 1 -C /usr/local/bin docker/docker && \
  wget -q -O /usr/local/bin/docker-compose "https://github.com/docker/compose/releases/download/${DOCKER_COMPOSE_VERSION}/docker-compose-$(uname -s)-$(uname -m)" && \
  chmod 0755 /usr/local/bin/docker-compose /usr/local/bin/docker && \
  groupadd -g ${DOCKER_GROUP_ID} docker

# Download Shell Check Binary
RUN wget -q -O - "https://github.com/koalaman/shellcheck/releases/download/${SHELLCHECK_VERSION}/shellcheck-${SHELLCHECK_VERSION}.linux.x86_64.tar.xz" | tar -xJf - --strip 1 -C /usr/local/bin shellcheck-${SHELLCHECK_VERSION}/shellcheck && \
  chmod 0755 /usr/local/bin/shellcheck

# Download Hadolint Binary
RUN wget -q -O /usr/local/bin/hadolint "https://github.com/hadolint/hadolint/releases/download/${HADOLINT_VERSION}/hadolint-Linux-x86_64" && \
  chmod 0755 /usr/local/bin/hadolint

# Install Terraform
# hadolint ignore=DL3003,DL3018,DL3013,DL4001,DL4006
RUN DOWNLOAD_FILE=$(curl -sL https://releases.hashicorp.com/terraform/index.json | jq -r '.versions[].builds[].url' | sort -t. -k 1,1n -k 2,2n -k 3,3n -k 4,4n | grep -E -v 'rc|beta|alpha' | grep -E 'linux.*amd64'| sort -ur | head -n 1) && \
  curl -Lo /tmp/terraform.zip "${DOWNLOAD_FILE}" && \
  cd /usr/bin && \
  unzip /tmp/terraform.zip && \
  chmod +x /usr/bin/terraform && \
  rm -rf /tmp/terraform.zip

# Set The Terraform Data Path
ENV TF_DATA_DIR=/project/.terraform

# hadolint ignore=DL4001
RUN curl -Lo /tmp/tflint.zip "https://github.com/terraform-linters/tflint/releases/download/v0.48.0/tflint_linux_amd64.zip" && \
  unzip /tmp/tflint.zip -d /usr/bin && \
  chmod +x /usr/bin/tflint && \
  rm -rf /tmp/tflint.zip

# Configure Non-Root User Settings And Project Path
RUN groupadd -g ${USER_GROUP_ID} user && \
  useradd -u ${USER_USER_ID} -g ${USER_GROUP_ID} -c "Non-Root User" -d "/home/user" -l -m user && \
  echo "user ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/user && \
  mkdir /project && \
  chown user:user /project && \
  usermod -a -G docker user

# Configure Runtime Settings
USER user

VOLUME /project
WORKDIR /project

CMD ["/bin/bash"]
