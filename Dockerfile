FROM ubuntu:24.04

ARG PYTHON_VERSION=3.7.2

RUN set -x \
    && apt-get update \
    && apt-get install -y \
        curl \
        git \
        build-essential \
        zlib1g-dev \
        libncurses5-dev \
        libgdbm-dev \
        libnss3-dev \
        libssl-dev \
        libreadline-dev \
        libffi-dev \
        libsqlite3-dev libreadline6-dev libbz2-dev libdb-dev libexpat1-dev liblzma-dev \
    && curl -sSL https://pyenv.run > /tmp/install-pyenv.sh \
    && chmod +x /tmp/install-pyenv.sh \
    && /tmp/install-pyenv.sh
ENV PATH="/root/.pyenv/bin:$PATH"
RUN MAKEOPTS="-j$(nproc)" pyenv install ${PYTHON_VERSION}
RUN pyenv global ${PYTHON_VERSION}


# 作業ディレクトリを設定
WORKDIR /src/

#ENV PYTHONUNBUFFERED=1
#ENV PYTHONMEMORY=8G

COPY src/requirements.txt /src/
RUN eval $(pyenv init --path) && pip install -r requirements.txt
RUN echo 'eval "$(pyenv init --path)"' >> ~/.bashrc
RUN echo 'eval "$(pyenv init -)"' >> ~/.bashrc

