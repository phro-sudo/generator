FROM alpine:latest

WORKDIR /home

RUN apk update \
    && apk add git python3 gcc musl-dev libsodium-dev make autoconf \
    && git clone https://github.com/cathugger/mkp224o.git \
	&& mkdir in \
	&& mkdir out

COPY filter.txt ./in

WORKDIR /home/mkp224o

RUN ./autogen.sh \
    && ./configure --enable-amd64-51-30k --enable-intfilter --enable-binsearch --enable-besort \
	&& make

CMD ["/bin/sh", "-c", "./mkp224o -f ../in/filter.txt -y >../out/foo.yml"]
