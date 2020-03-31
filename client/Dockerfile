# MULTI STEP

# BUILDER
FROM node:alpine as builder
WORKDIR "/app"
COPY ./package.json ./
RUN npm install
COPY . .
RUN npm run build

# DEPLOY
FROM nginx
# ESTO ES NECESARIO PORQUE ESB lo usa para saber q tiene a mapear este puerto
# Si pongo el listen en el default.conf esta linea ya no es necesaria
EXPOSE 3000
COPY ./nginx/default.conf /etc/nginx/conf.d/default.conf
COPY --from=builder /app/build /usr/share/nginx/html
