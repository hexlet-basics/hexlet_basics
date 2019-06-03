FROM williamyeh/ansible:ubuntu18.04

ENV VERSION 1
RUN apt-get update && apt-get upgrade -yyq
RUN apt-get install -yqq vim curl
#RUN curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -
#RUN echo "deb https://apt.kubernetes.io/ kubernetes-xenial main" | tee -a /etc/apt/sources.list.d/kubernetes.list
#RUN echo "deb http://packages.cloud.google.com/apt cloud-sdk-bionic main" | tee -a /etc/apt/sources.list.d/google-cloud-sdk.list
#RUN curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -
#RUN apt-get update
#RUN apt-get install google-cloud-sdk kubectl -yyq

#RUN pip install docker
#RUN pip install python-consul
#RUN apt-get install ufw cron iproute2 libltdl7 -yyq
##NOTE for vault edit
#RUN apt-get install vim -yyq

#COPY requirements.yml /tmp/requirements.yml

#RUN ansible-galaxy install -f -r /tmp/requirements.yml
