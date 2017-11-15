FROM nginx

COPY dist/ /usr/share/nginx/html/
RUN find /usr/share/nginx/html
COPY nginx.conf /etc/nginx/nginx.conf
RUN chmod -R 755 /usr/share/nginx/html
