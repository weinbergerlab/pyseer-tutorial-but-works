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
