FROM nginx:alpine

COPY dist/* /usr/share/nginx/html/
COPY nginx_vuerouter.conf /etc/nginx/nginx.conf
RUN chmod -R 755 /usr/share/nginx/html
