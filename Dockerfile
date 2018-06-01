FROM resin/rpi-raspbian

# software and firmware updates
RUN apt-get update && apt-get upgrade && apt-get clean
RUN apt-get install apt-utils
RUN apt-get install bzip2
RUN apt-get install libgomp1

# berryconda
RUN curl -s -L https://github.com/jjhelmus/berryconda/releases/download/v2.0.0/Berryconda3-2.0.0-Linux-armv6l.sh > miniconda3.sh\
    && bash miniconda3.sh -b -p /opt/miniconda3\
    && rm miniconda3.sh
ENV PATH /opt/miniconda3/bin:$PATH

CMD /bin/bash