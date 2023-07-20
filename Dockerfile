FROM maven as Build
WORKDIR /app
COPY /root/.jenkins/workspace/website/webapp/target/webapp.war /app
RUN mvn install

FROM tomcat
RUN sudo apt install openjdk-11-jdk
WORKDIR /app
COPY --from=build /app/webapp/* /app/var/lib/tomcat/webapps
EXPOSE 1010
RUN ["webapp"]