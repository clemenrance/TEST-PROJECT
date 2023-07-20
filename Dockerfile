FROM maven as Build
WORKDIR /app
COPY /root/.jenkins/workspace/website/webapp/target/webapp.war /app
RUN mvn install

FROM nginx:alpine
WORKDIR /app
COPY --from=build /app/target/webapp /app
EXPOSE 1010
