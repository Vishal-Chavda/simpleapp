FROM node:16-alpine as build-stage
RUN mkdir /opt/simpleapp
WORKDIR /opt/simpleapp
ADD . .
RUN npm install
RUN npm run build

FROM nginx:latest as production-stage
COPY --from=build-stage /opt/simpleapp/build /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]

#CMD ["npm", "start", "&;"]
#EXPOSE 3000
