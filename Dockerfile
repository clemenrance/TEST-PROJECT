FROM maven as Build
WORKDIR /app
COPY /root/.jenkins/workspace/website/webapp/target/webapp.war /app
RUN mvn install

FROM tomcat9
WORKDIR /app
COPY --from=build /app/webapp /app/var/lib/tomcat9/webapps
EXPOSE 1010
RUN ["webapp"]