FROM node:lts-alpine

WORKDIR /app

RUN npm install -g docsify-cli

COPY . /app

EXPOSE 3000

CMD ["docsify", "serve", "."]