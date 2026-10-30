# Jenkins controller with JDK 21 and Docker CLI (uses the host Docker daemon via socket)
FROM jenkins/jenkins:lts-jdk21
USER root
COPY --from=docker:cli /usr/local/bin/docker /usr/local/bin/docker
USER jenkins
RUN jenkins-plugin-cli --plugins workflow-aggregator git github timestamper junit credentials-binding
