FROM nginx

COPY hexlet-basics.conf.template /hexlet-basics.conf.template
COPY maintenance.html /etc/nginx/html/maintenance.html

RUN \
  apt-get update \
  && apt-get -y install gettext-base \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*

ENTRYPOINT envsubst '$NGINX_SERVER_ADDRESS' < /hexlet-basics.conf.template > /etc/nginx/conf.d/default.conf && exec nginx -g 'daemon off;'
