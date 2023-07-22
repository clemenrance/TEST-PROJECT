FROM maven as build
WORKDIR /app
COPY . /app
RUN mvn install

FROM nginx:alpine
WORKDIR /app
COPY --from=build ./app/webapp/* /app/urs/share/nginx/html/webapp