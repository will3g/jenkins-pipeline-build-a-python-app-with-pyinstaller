FROM jenkins/jenkins:2.332.2-jdk11
USER root
RUN apt-get update && apt-get install -y lsb-release
RUN curl -fsSLo /usr/share/keyrings/docker-archive-keyring.asc \
  https://download.docker.com/linux/debian/gpg
RUN echo "deb [arch=$(dpkg --print-architecture) \
  signed-by=/usr/share/keyrings/docker-archive-keyring.asc] \
  https://download.docker.com/linux/debian \
  $(lsb_release -cs) stable" > /etc/apt/sources.list.d/docker.list
RUN apt-get update && apt-get install -y docker-ce-cli
USER jenkins
# https://www.jenkins.io/doc/book/blueocean/
RUN jenkins-plugin-cli --plugins "blueocean:1.25.3 docker-workflow:1.28"

# FROM python:3.8
# ADD . /flask-with-ci-cd
# WORKDIR /flask-with-ci-cd
# RUN pip install -r requirements.txt
# EXPOSE 5000
# CMD ["python", "./src/app.py"]