FROM maven as Build
WORKDIR /app
COPY . /app
RUN mvn install

FROM tomcat
RUN sudo apt install openjdk-11-jdk /bin/sh
WORKDIR /app
COPY --from=build /app/webapp/* /app/var/lib/tomcat/webapps
EXPOSE 1010
RUN ["webapp"]