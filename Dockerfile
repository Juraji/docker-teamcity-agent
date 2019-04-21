FROM openjdk:11-jdk

VOLUME /data/teamcity_agent/conf
EXPOSE 9090

COPY run-agent.sh /run-agent.sh
COPY run-services.sh /run-services.sh
COPY dist/buildagent /opt/buildagent

RUN apt-get update \
    && apt install -y --no-install-recommends
        apt-utils \
        openjfx \
        sudo \
        git \
    && apt clean all
    && useradd -m buildagent \
    && chmod +x /opt/buildagent/bin/*.sh \
    && chmod +x /run-agent.sh /run-services.sh \
    && sync

CMD ["/run-services.sh"]
