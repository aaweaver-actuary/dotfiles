FROM alpine:latest

WORKDIR /alpine

COPY ./install_alpine_dbt /alpine/install_alpine_dbt
COPY ./install_alpine_ssh /alpine/install_alpine_ssh

RUN apk update && apk add --no-cache zsh && \
    chmod +x /alpine/install_alpine_dbt && \
    chmod +x /alpine/install_alpine_ssh && \
    rm -rf /var/cache/apk/*

CMD ["/bin/zsh"]
