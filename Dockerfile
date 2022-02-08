FROM python:3.10

# Install Nginx, cmake
RUN apt-get update && apt-get install nginx cmake -y --no-install-recommends && apt-get upgrade python3-pip -y

COPY ./nginx.default /etc/nginx/sites-available/default
RUN ln -sf /dev/stdout /var/log/nginx/access.log && ln -sf /dev/stderr /var/log/nginx/error.log

workdir /usr/src/app/
COPY . .
RUN pip install --no-cache-dir -r ./requirements.txt
RUN chown -R www-data:www-data /usr/src/app

STOPSIGNAL SIGTERM
workdir /usr/src/app/helloworld
RUN chmod +x ./run.sh
CMD ["./run.sh"]
