FROM python:3.6.7-alpine

ENV PYTHONUNBUFFERED 1

COPY ./requirements.txt /requirements.txt
# Install python and postgres dependencies under a virtual package
RUN apk add --update --no-cache postgresql-client
RUN apk add --update --no-cache --virtual .tmp-build-deps \
      gcc libc-dev linux-headers postgresql-dev musl-dev
RUN pip install --upgrade pip -r /requirements.txt
# Delete virtual packages as we installed our dependencies
RUN apk del .tmp-build-deps

RUN mkdir /app
WORKDIR /app
COPY ./ /app

COPY ./wait-for /bin/wait-for
RUN chmod 777 -R /bin/wait-for

RUN adduser -D user
USER user
