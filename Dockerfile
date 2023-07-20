FROM maven as Build
WORKDIR /app
COPY . /app
RUN mvn install

FROM tomcat
RUN mkdir /app/tomcat
WORKDIR /app/tomcat
COPY --from=build /app/webapp/* /app/var/lib/tomcat/webapps
EXPOSE 1010
RUN ["app/tomcat/bin/catalina.sh", "run"]