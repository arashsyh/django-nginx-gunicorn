#!/bin/sh
python manage.py makemigrations
python manage.py migrate
gunicorn helloworld.wsgi  --timeout 60 --user www-data --bind 0.0.0.0:8010 --workers 15 & nginx -g 'daemon off;'
