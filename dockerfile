FROM node:8.4

WORKDIR  /app

COPY package.json ./

RUN npm i

COPY server.js ./
COPY lib ./lib
COPY views ./views
COPY test ./test

CMD [ "node","server.js"]

