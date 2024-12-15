FROM python:3.11-alpine

COPY entrypoint /entrypoint

ENTRYPOINT [ "/entrypoint" ]

RUN     addgroup -g 54000 rysen && \
        adduser -D -u 54000 -G rysen rysen && \
        apk update && \
        apk add git gcc musl-dev && \
        pip install --upgrade pip && \
        pip cache purge && \
        cd /opt && \
        git clone https://github.com/ShaYmez/RYSEN2.git rysen && \
        cd /opt/rysen && \
        pip install --no-cache-dir -r requirements.txt && \
        pip uninstall --no-cache-dir -y twisted && \
        pip install Twisted==16.3.0 && \
        apk del git gcc musl-dev && \
        chown -R rysen:rysen /opt/rysen

USER rysen

ENTRYPOINT [ "/entrypoint" ]
