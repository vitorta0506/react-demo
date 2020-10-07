FROM node:alpine as buildwebsite

WORKDIR /app

COPY ./package*.json ./

RUN yarn --silent

COPY ./ ./

RUN yarn build

FROM nginx:alpine

WORKDIR /buildwebsite/build

COPY default.conf /etc/nginx/conf.d

COPY --from=buildwebsite /app/build/ ./

EXPOSE 80

ENTRYPOINT ["/usr/sbin/nginx"]

CMD ["-g", "daemon off;"]