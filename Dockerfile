FROM maven as Build
WORKDIR /app
COPY . .
RUN mvn install

FROM nginx:alpine
WORKDIR /app
COPY --from=build /app/target/webapp.war /app
EXPOSE 1010
