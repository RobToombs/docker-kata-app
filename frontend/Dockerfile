FROM alpine:latest

# Add Lighttp Server
RUN apk update && apk upgrade
RUN apk add --update lighttpd

# Copy our Http server config file over, and our built html/js files
COPY ./web/conf/* /etc/lighttpd/
COPY ./web/html/* /var/www/html/

EXPOSE 80

CMD ["lighttpd","-D","-f","/etc/lighttpd/lighttpd.conf"]

