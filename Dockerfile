ARG CUDA_TAG=11.2.2-cudnn8-devel-ubuntu20.04

FROM nvidia/cuda:$CUDA_TAG
ARG PYTHON_VERSION=3.10

ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update && \
    apt-get -y install --no-install-recommends software-properties-common && \
    add-apt-repository ppa:deadsnakes/ppa && \
    apt-get update && \
    apt-get -y install --no-install-recommends \
      curl \
      ffmpeg \
      git \
      gosu \
      libgtk-3-dev \
      libjpeg-dev \
      libpng-dev \
      nano \
      openssh-server \
      python$PYTHON_VERSION-dev \
      python$PYTHON_VERSION-distutils \
      python$PYTHON_VERSION-venv \
      tmux \
      xvfb && \
    curl -sS https://bootstrap.pypa.io/get-pip.py | python$PYTHON_VERSION && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN pip install pipenv

COPY ./docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh
RUN chmod +x /usr/local/bin/docker-entrypoint.sh

EXPOSE 22 6006 8080 8888

RUN mkdir -m 777 /venv && \
    echo WORKON_HOME=/venv >> /etc/environment

ENTRYPOINT ["/usr/local/bin/docker-entrypoint.sh"]
CMD ["sh", "-c", "tail -f /dev/null"]
