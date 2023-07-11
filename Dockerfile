FROM docker.io/library/alpine:latest
RUN apk upgrade --no-cache
RUN apk add --no-cache execline libintl sqlite-libs icu-libs
ADD https://radarr.servarr.com/v1/update/master/updatefile?os=linuxmusl&runtime=netcore&arch=x64 /tmp/radarr.tar.gz
RUN mkdir -p /opt/radarr/bin
RUN tar xf /tmp/radarr.tar.gz -C /opt/radarr/bin --strip-components=1
RUN rm /tmp/radarr.tar.gz
RUN rm -r /opt/radarr/bin/Radarr.Update
RUN echo UpdateMethod=Docker >/opt/radarr/package_info
EXPOSE 7878
ENTRYPOINT ["/opt/radarr/bin/Radarr", "--nobrowser"]
CMD ["--data=/container/data"]
