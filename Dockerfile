# building node and the static website.  the as on the FROM line is a tag
FROM node:alpine as builder
WORKDIR '/app'
COPY package.json .
RUN npm install
RUN chown -R node.node /app
COPY src .
COPY public .
COPY build .
COPY package-lock.json .
RUN chown -R node.node /app
CMD /bin/echo 'starting npm build'
RUN npm run build

# the FROM command effectively ends the previous block
# nginx defaults to start
FROM nginx
CMD /bin/echo 'starting nginx'
COPY --from=builder /app/build /usr/share/nginx/html