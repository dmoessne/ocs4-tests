#!/bin/sh
uname -n >> /usr/share/nginx/html/index.html
nginx -g 'daemon off;'

