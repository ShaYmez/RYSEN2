FROM python:alpine3.11

COPY entrypoint /entrypoint

ENTRYPOINT [ "/entrypoint" ]

RUN adduser -D -u 54000 radio && \
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
        chown -R radio: /opt/rysen

USER radio

ENTRYPOINT [ "/entrypoint" ]
