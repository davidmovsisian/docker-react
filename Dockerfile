#build phase
FROM node:16-alpine as builder
USER node

RUN mkdir -p /home/node/app
WORKDIR /home/node/app
 
COPY --chown=node:node ./package.json ./
RUN npm install
COPY --chown=node:node ./ ./

Run npm run build

#run phase
FROM nginx
EXPOSE 80
#copy content of /home/node/app/build from build phase to /usr/share/nginx/html
COPY --from=builder /home/node/app/build /usr/share/nginx/html

