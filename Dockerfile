FROM maven as build
WORKDIR /app
COPY . /app
RUN mvn install

FROM nginx:alpine
COPY --from=build /app/webapp/target/webapp.war /urs/share/nginx/html