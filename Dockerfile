FROM node:lts AS angular-app1
WORKDIR /app
COPY package.json /app
RUN npm install --silent
COPY . .
RUN npm run build

FROM nginx:alpine
VOLUME [ "/var/cache/nginx" ]
COPY --from=angular-app1 app/dist/app1 /usr/share/nginx/html
COPY ./config/nginx.conf /etc/nginx/conf.d/default.conf
