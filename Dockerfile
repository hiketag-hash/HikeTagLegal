FROM nginx:1.27-alpine

COPY nginx/legal.conf /etc/nginx/conf.d/default.conf
COPY legal/ /usr/share/nginx/html/legal/
COPY doneaza/ /usr/share/nginx/html/doneaza/

EXPOSE 80
