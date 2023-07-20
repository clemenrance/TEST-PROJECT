FROM maven as Build
WORKDIR /app
COPY . /app
RUN mvn install

FROM tomcat
RUN apt install openjdk-11-jdk /bin/bash
WORKDIR /app
COPY --from=build /app/webapp/* /app/var/lib/tomcat/webapps
EXPOSE 1010
RUN ["webapp"]