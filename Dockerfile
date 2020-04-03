FROM ubuntu:19.10
ARG DEBIAN_FRONTEND=noninteractive

# Install anaconda
RUN \
  apt-get -qq update && \
  apt-get install -qq --yes --no-install-recommends curl wget ca-certificates && \
  cd /tmp && \
  curl -k -L -O https://repo.anaconda.com/archive/Anaconda3-2020.02-Linux-x86_64.sh && \
  bash /tmp/Anaconda3-2020.02-Linux-x86_64.sh -b -p /conda

ENV PATH="/conda/bin:${PATH}"

# Install pyseer and poppunk
RUN /conda/bin/conda config --add channels defaults
RUN /conda/bin/conda config --add channels bioconda
RUN /conda/bin/conda config --add channels conda-forge
RUN /conda/bin/conda install -y pyseer poppunk

# Install fsm-lite
RUN \
  apt-get -qq update && \
  apt-get install -qq --yes --no-install-recommends build-essential zip unzip libsdsl-dev libsdsl3 libdivsufsort-dev && \
  cd /tmp && \
  curl -L -O https://github.com/nvalimak/fsm-lite/archive/v1.0-stable.zip && \
  unzip v1.0-stable.zip && \
  cd fsm-lite-1.0-stable && \
  make depend && make && \
  cp fsm-lite /usr/local/bin && \
  apt-get remove -qq --yes --no-install-recommends build-essential zip unzip libsdsl-dev && \
  apt-get autoremove --yes
