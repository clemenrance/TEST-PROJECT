FROM nginx:alpine
COPY ./webapp/src/main/webapp /usr/share/nginx/html
