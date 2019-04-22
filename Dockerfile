FROM openjdk:11-jdk

VOLUME /data/teamcity_agent/conf
EXPOSE 9090

COPY run-agent.sh /run-agent.sh
COPY run-services.sh /run-services.sh
COPY dist/buildagent /opt/buildagent

# Environment setup
RUN apt-get update \
    && apt install -y --no-install-recommends \
        apt-utils \
        openjfx \
        sudo \
        git \
    # Clean apt
    && apt clean all \
    # Setup BASH as default shell
    && ln -s bash /bin/sh.bash \
    && sudo mv /bin/sh.bash /bin/sh

# Install Go
RUN wget https://dl.google.com/go/go1.12.4.linux-amd64.tar.gz \
    && tar -xvf go1.12.4.linux-amd64.tar.gz \
    && mv go /usr/local \
    && export GOROOT=/usr/local/go
ENV GOROOT=/usr/local/go
ENV GOPATH=$HOME/Go
ENV PATH=$GOPATH/bin:$GOROOT/bin:$PATH

# Install Github Release
RUN go get github.com/aktau/github-release

# Setup build agent
RUN useradd -m buildagent \
        && chmod +x /opt/buildagent/bin/*.sh \
        && chmod +x /run-agent.sh /run-services.sh \
        && sync

CMD ["./run-services.sh"]
