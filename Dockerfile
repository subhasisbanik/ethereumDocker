FROM ubuntu:latest
RUN apt-get update						&&\ 
    apt-get install -y software-properties-common		&&\
    add-apt-repository -y ppa:ethereum/ethereum			&&\
    apt-get update						&&\
    apt-get install -y ethereum                                 &&\
    apt-get update                                              &&\
    apt-get install -y vim curl
