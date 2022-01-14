FROM archlinux

MAINTAINER James Danielson

RUN pacman --noconfirm -Syu
RUN pacman --noconfirm -S base-devel rustup

RUN useradd -m builder

### ARCH BUILDS ###
RUN su builder -c 'rustup default stable'

RUN pacman --noconfirm -S vim screen
### END OF ARCH ###

### WINDOWS BUILDS ###
## Windows dependencies
#RUN pacman --noconfirm -S mingw-w64-gcc

## Windows 64bit
#RUN rustup target add x86_64-pc-windows-gnu
#ADD static/cargo/win-amd64.config /root/

## Windows 32bit
#RUN rustup target add i686-pc-windows-gnu
### END OF WINDOWS###

ADD project/ /proj/
RUN chown -R builder:builder /proj/

# Build project
RUN cd /proj/ && su builder -c 'cargo build'
