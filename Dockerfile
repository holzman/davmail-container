FROM ubuntu:18.04
RUN apt-get update  && apt-get install -y default-jre unzip
RUN apt-get install -y xdg-utils
RUN apt-get install -y openjfx
RUN useradd davuser
RUN mkdir /home/davuser && chown davuser:davuser /home/davuser

RUN apt-get install -y git default-jdk ant

USER davuser
WORKDIR /home/davuser

#RUN git clone https://github.com/mguessan/davmail.git davmail-src
RUN git clone -b backoff https://github.com/holzman/davmail.git davmail-src

RUN cd davmail-src &&  ANT_OPTS=-Dfile.encoding=UTF-8 ant
RUN unzip davmail-src/dist/davmail-5.4.0-trunk.zip

COPY --chown=davuser:davuser davmail.properties /home/davuser/davmail.properties
CMD ./davmail ./davmail.properties


