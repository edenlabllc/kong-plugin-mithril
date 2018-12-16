FROM alpine:3.6
LABEL maintainer Marco Palladino, marco@mashape.com

ENV KONG_VERSION 0.14.1
ENV KONG_SHA256 e29937c5117ac2debcffe0d0016996dd5f0c516ef628f1edc029138715981387

RUN apk update \
    && apk add --no-cache --virtual .build-deps wget tar ca-certificates \
	&& apk add --no-cache libgcc openssl pcre perl tzdata curl \
	&& apk add git \
	&& apk add musl-dev \
	&& apk add gcc \
	&& apk add pcre-dev \
	&& wget -O kong.tar.gz "https://bintray.com/kong/kong-community-edition-alpine-tar/download_file?file_path=kong-community-edition-$KONG_VERSION.apk.tar.gz" \
	&& echo "$KONG_SHA256 *kong.tar.gz" | sha256sum -c - \
	&& tar -xzf kong.tar.gz -C /tmp \
	&& rm -f kong.tar.gz \
	&& cp -R /tmp/usr / \
	&& rm -rf /tmp/usr \
	&& cp -R /tmp/etc / \
	&& rm -rf /tmp/etc \
	&& apk del .build-deps

RUN luarocks install kong-plugin-mithril

COPY docker-entrypoint.sh /docker-entrypoint.sh
ENTRYPOINT ["/docker-entrypoint.sh"]

EXPOSE 8000 8443 8001 8444

STOPSIGNAL SIGTERM

CMD ["kong", "docker-start"]
