FROM java:8-jre

LABEL MAINTAINER="edp_support@groups.163.com"

RUN cd / \
	&& mkdir -p /opt/davinci \
	&& wget https://github.com/edp963/davinci/releases/download/v0.3.0-beta.6/davinci-assembly_3.0.1-0.3.1-SNAPSHOT-dist-beta.6.zip \
	&& unzip davinci-assembly_3.0.1-0.3.1-SNAPSHOT-dist-beta.6.zip -d /opt/davinci\
	&& rm -rf davinci-assembly_3.0.1-0.3.1-SNAPSHOT-dist-beta.6.zip

RUN mkdir -p /opt/phantomjs-2.1.1 \
    && wget https://bitbucket.org/ariya/phantomjs/downloads/phantomjs-2.1.1-linux-x86_64.tar.bz2 \
	&& unzip phantomjs-2.1.1-linux-x86_64.tar.bz2 \
	&& rm -rf phantomjs-2.1.1-linux-x86_64.tar.bz2 \
	&& mv phantomjs-2.1.1-linux-x86_64/bin/phantomjs /opt/phantomjs-2.1.1/phantomjs \
	&& rm -rf phantomjs-2.1.1-linux-x86_64


ADD bin/start.sh /opt/davinci/bin/start.sh
ADD config/application.yml /opt/davinci/config/application.yml

RUN chmod +x /opt/phantomjs-2.1.1/phantomjs && chmod +x /opt/davinci/bin/start.sh


ENV DAVINCI3_HOME /opt/davinci
ENV PHANTOMJS_HOME /opt/phantomjs-2.1.1

WORKDIR /opt/davinci

CMD ["./bin/start-server.sh"]

EXPOSE 8080