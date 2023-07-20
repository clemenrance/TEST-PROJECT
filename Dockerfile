FROM maven as Build
WORKDIR /app
COPY . /app
RUN mvn install

FROM tomcat
RUN apt-get install java -y /bin/sh
WORKDIR /app
COPY --from=build /app/webapp/* /app/var/lib/tomcat/webapps
EXPOSE 1010
RUN ["webapp"]