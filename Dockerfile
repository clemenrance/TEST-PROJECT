FROM maven as Build
WORKDIR /app
COPY . /app
RUN mvn install

FROM tomcat
WORKDIR /app
COPY --from=build /app/* /app/var/lib/tomcat/webapps
RUN apt update
RUN apt install default-jdk -y
EXPOSE 1010