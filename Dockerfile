FROM debian:stable-slim
ENV DEBIAN_FRONTEND noninteractive

ADD mycloudreve.ini /root/cloudreve/mycloudreve.ini
ADD aria2.conf /root/aria2/aria2.conf
ADD trackers-list-aria2.sh /root/aria2/trackers-list-aria2.sh
ADD run.sh /root/cloudreve/run.sh

RUN apt-get update \
    && apt-get install wget curl aria2 -y

RUN wget -qO https://github.com/742481030/Cloudreve/releases/download/3.1.1.0001/cloudreve_linux_V3.1.1-5-g40414fe_.Commit.40414fe_amd64 \
	#wget -qO cloudreve.tar.gz https://github.com/moeYuiYui/Cloudreve/releases/download/3.1.1/cloudreve_sp_3.1.1_linux_amd64.tar.gz \
	#wget -qO cloudreve.tar.gz https://github.com/cloudreve/Cloudreve/releases/download/3.1.1/cloudreve_3.1.1_linux_amd64.tar.gz \
    && wget -qO /root/aria2/dht.dat https://github.com/P3TERX/aria2.conf/raw/master/dht.dat \
    && wget -qO /root/aria2/dht6.dat https://github.com/P3TERX/aria2.conf/raw/master/dht6.dat
    
RUN tar -zxvf cloudreve.tar.gz -C /root/cloudreve
RUN touch /root/aria2/aria2.session /root/aria2/aria2.log
RUN chmod +x /root/cloudreve/cloudreve \
    && chmod +x /root/aria2/trackers-list-aria2.sh \
    && chmod +x /root/cloudreve/run.sh
RUN mkdir -p /root/Download

CMD /root/cloudreve/run.sh
