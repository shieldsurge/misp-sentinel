FROM ubuntu:jammy

# Install core components
ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && \
    apt-get dist-upgrade -y && apt-get upgrade && apt-get autoremove -y && apt-get clean && \
    apt-get install -y software-properties-common
    
RUN apt-get install -y python3 python3-pip git cron supervisor vim emacs nano curl
RUN pip3 install --upgrade pip

WORKDIR /opt/
RUN git clone https://github.com/microsoftgraph/security-api-solutions.git
RUN pip3 install requests requests-futures pymisp

RUN ( \
    echo '[supervisord]'; \
    echo 'nodaemon = true'; \
    echo ''; \
) >> /etc/supervisor/conf.d/supervisord.conf

ADD run.sh /run.sh
RUN chmod 0755 /run.sh
RUN touch /.firstboot.tmp
ENTRYPOINT ["/run.sh"]
