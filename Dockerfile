FROM maven as build
WORKDIR /app
COPY . /app
RUN mvn install

FROM nginx:alpine
COPY --from=build ./webapp/* ./html/webapp