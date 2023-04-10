FROM jenkins/jenkins:lts
USER root
RUN apt-get update && apt-get install -y docker.io
RUN touch /var/run/docker.sock && chown jenkins:docker /var/run/docker.sock
RUN usermod -aG docker jenkins
USER jenkins

