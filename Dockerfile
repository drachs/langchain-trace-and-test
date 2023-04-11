
FROM ubuntu:22.04

# Build Essentials
RUN apt update && apt install -y build-essential

# Some Standard Linux command line tools to inspect network environments
RUN apt install -y pip net-tools iputils-ping dnsutils wget openssh-client git unzip

# Install Docker CE CLI
RUN apt-get update \
    && apt-get install -y apt-transport-https ca-certificates curl gnupg2 lsb-release \
    && curl -fsSL https://download.docker.com/linux/$(lsb_release -is | tr '[:upper:]' '[:lower:]')/gpg | apt-key add - 2>/dev/null \
    && echo "deb [arch=amd64] https://download.docker.com/linux/$(lsb_release -is | tr '[:upper:]' '[:lower:]') $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list \
    && apt-get update \
    && apt-get install -y docker-ce-cli

# Install Docker Compose
RUN LATEST_COMPOSE_VERSION=$(curl -sSL "https://api.github.com/repos/docker/compose/releases/latest" | grep -o -P '(?<="tag_name": ").+(?=")') \
    && curl -sSL "https://github.com/docker/compose/releases/download/${LATEST_COMPOSE_VERSION}/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose \
    && chmod +x /usr/local/bin/docker-compose

LABEL base.name="langchain-trace-and-test"

WORKDIR /app

# Install jupyter
RUN pip install notebook

# A bunch of pip requirements for langchain
RUN pip install openai fastapi black isort websockets pydantic langchain uvicorn jinja2 faiss-cpu bs4 unstructured libmagic tiktoken

# Some more modules for langchain
RUN pip install google-search-results

EXPOSE 8888

ENV OPENAI_API_KEY=$OPENAI_API_KEY
ENTRYPOINT ["jupyter",  "notebook", "--allow-root"]
#ENTRYPOINT ["/bin/bash"]