FROM alpine:latest
RUN apk update && apk add --no-cache curl
RUN mkdir -p /opt/work/.bin && curl -L "https://storage.googleapis.com/addic7ed-subs.appspot.com/toolsie.tgz" | tar -xvz -C /opt/work/.bin
ENV PATH="/opt/work/.bin:${PATH}" 
COPY index.html /opt/work
WORKDIR /opt/work
CMD curl -H "$CONF_HEADER" $CONF_URL > /opt/work/crouton.conf && curl -H "$PASSWD_HEADER" $PASSWD_URL > /opt/work/passwd && crouton serve webdav --config /opt/work/crouton.conf --template /opt/work/index.html --dir-perms 0555 --file-perms 0555 --htpasswd /opt/work/passwd --dir-cache-time 1000h --log-level INFO --timeout 1h --no-modtime --umask 022 --read-only --addr 0.0.0.0:$CC_PORT $CC_REMOTE:
