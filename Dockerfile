FROM maven as Build
WORKDIR /app
COPY . /app
RUN mvn install

FROM tomcat
RUN openjdk:8
WORKDIR /app
COPY --from=build /app/* /app/var/lib/tomcat/webapps
EXPOSE 1010
CMD ["./app"]