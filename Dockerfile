FROM alpine

RUN apk add curl

ENV SUPERCRONIC_URL=https://github.com/aptible/supercronic/releases/download/v0.2.1/supercronic-linux-amd64 \
    SUPERCRONIC=supercronic-linux-amd64 \
    SUPERCRONIC_SHA1SUM=d7f4c0886eb85249ad05ed592902fa6865bb9d70

RUN curl -fsSLO "$SUPERCRONIC_URL" \
 && echo "${SUPERCRONIC_SHA1SUM}  ${SUPERCRONIC}" | sha1sum -c - \
 && chmod +x "$SUPERCRONIC" \
 && mv "$SUPERCRONIC" "/usr/local/bin/${SUPERCRONIC}" \
 && ln -s "/usr/local/bin/${SUPERCRONIC}" /usr/local/bin/supercronic

ENV REPLIBYTE_URL=https://github.com/Qovery/Replibyte/releases/download/v0.9.6/replibyte_v0.9.6_x86_64-unknown-linux-musl.tar.gz \
    REPLIBYTE=replibyte_v0.9.6_x86_64-unknown-linux-musl.tar.gz

RUN curl -fsSLO "$REPLIBYTE_URL" \
 && tar -xzf "$REPLIBYTE" \
 && chmod +x replibyte \
 && mv replibyte /usr/local/bin/replibyte

RUN mkdir -p /tmp/replibyte
COPY crontab crontab
COPY replibyte.yaml replibyte.yaml

CMD supercronic ./crontab
