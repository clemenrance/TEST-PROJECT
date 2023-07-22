FROM maven as build
WORKDIR /app
COPY . /app
RUN mvn install

FROM nginx:alpine
COPY --from=build /app/webapp/target/webapp.war /usr/share/nginx/html
CMD ["java","-jar","webapp.war"]