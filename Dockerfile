##
## author: Piotr Stawarski <piotr.stawarski@zerodowntime.pl>
##

ARG CENTOS_VERSION=latest
ARG DEX_VERSION=master

FROM golang:1 as app-builder

COPY login-app/ /go/src/login-app
WORKDIR /go/src/login-app

RUN go get -v
RUN go build

## ## ## ## ##

FROM alpine:3
RUN apk add --no-cache --update ca-certificates openssl
RUN apk add --no-cache libc6-compat
COPY --from=app-builder /go/src/login-app/login-app /usr/local/bin/login-app

COPY docker-entrypoint.sh /docker-entrypoint.sh

ENV DEX_CLIENT_ID="example-app"
ENV DEX_CLIENT_SECRET="ZXhhbXBsZS1hcHAtc2VjcmV0"
ENV DEX_ISSUER="http://127.0.0.1:5556/dex"
ENV DEX_LISTEN="http://0.0.0.0:5555"
ENV DEX_REDIRECT_URI="http://127.0.0.1:5555/callback"

ENV DEX_SKIP_FORM=""
ENV DEX_OFFLINE_ACCESS="yes"
ENV DEX_EXTRA_SCOPES="groups"
ENV DEX_CROSS_CLIENT=""

EXPOSE 5555

ENTRYPOINT ["/docker-entrypoint.sh"]
