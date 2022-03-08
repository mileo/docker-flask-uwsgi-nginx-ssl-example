FROM python:3.6-slim

COPY ./app /srv/flask_app
WORKDIR /srv/flask_app

RUN set -x; \
        apt-get update \
        && apt-get install -y --no-install-recommends \
        nginx python3-dev build-essential ssl-cert \
        && apt-get clean \
        && rm -rf /var/lib/apt/lists/*

RUN pip install -r requirements.txt --src /usr/local/src

COPY ./nginx/flask.conf /etc/nginx/nginx.conf
COPY ./nginx/includes/ /etc/nginx/includes/

RUN chmod +x ./start.sh

EXPOSE 80 443

CMD ["./start.sh"]
