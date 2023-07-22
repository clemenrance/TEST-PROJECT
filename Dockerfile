FROM maven as Build
WORKDIR /app
COPY . /app
RUN mvn install

FROM nginx:alpine
COPY ./webapp/target/webapp/* ./app/usr/share/nginx/html/webapp