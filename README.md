# docker-teamcity-agent
A custom Docker image for the TeamCity agent

### Base Image
[openjdk:11-jdk](https://hub.docker.com/_/openjdk)

### SDK
* OpenJDK 11
* OpenJFX 11

### Teamcity Buildagent
_This only applies to the image deployed on [the Docker Hub](https://hub.docker.com/r/juraji/teamcity-agent)._
* 2018.x

## Build it yourself

1. Download the build agent zip file from Teamcity.  
_You can get the zip by clicking "agents" at the top of the screen, within Teamcity_
2. Unpack the zip into `./dist/buildagent`.
3. Copy `dist/buildagent/conf` to `dist/buildagent/conf_dist`.
3. Build the agent image `docker build -t teamcity-agent .`.

> Note: Keep line endings in `./run-agent.sh` and `./run-services.sh` set to `LF`, or the image will fail to run
