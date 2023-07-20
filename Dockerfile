FROM maven as Build
WORKDIR /app
COPY . /app
RUN mvn install

FROM tomcat
WORKDIR /app
COPY --from=build /app/webapp/* /app/var/lib/tomcat/webapps
EXPOSE 1010
RUN ["app/tomcat/bin/catalina.sh", "run"]