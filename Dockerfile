FROM alpine:edge AS build

WORKDIR /workspace

RUN apk update

RUN apk add npm

RUN npm i -g stylus

WORKDIR /code

COPY bin/css/style.styl .

RUN stylus style.styl

FROM httpd

WORKDIR /usr/local/apache2/htdocs

COPY bin .

COPY --from=build /code/style.css css