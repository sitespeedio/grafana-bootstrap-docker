FROM pstauffer/curl

RUN apk --update upgrade && \
    apk add --update jq && \
    rm -rf /var/cache/apk/*

ADD ./datasources /datasources
ADD ./dashboards /dashboards

ADD ./entrypoint.sh /

CMD /entrypoint.sh
