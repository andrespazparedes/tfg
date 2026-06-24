# Desarrollo
FROM node:20-alpine AS dev
WORKDIR /app
COPY package*.json ./
RUN npm install
# No copiamos el código fuente aquí porque usaremos un volumen en docker-compose
CMD ["npm", "run", "dev"]

# Build
FROM node:20-alpine AS build
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
RUN npm run build

# Serve
FROM nginx:alpine AS prod
COPY --from=build /app/dist /usr/share/nginx/html
COPY nginx.conf /etc/nginx/conf.d/default.conf
EXPOSE 80
