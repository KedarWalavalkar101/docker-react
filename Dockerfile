FROM node:22-alpine AS builder

RUN node -v
RUN npm -v
WORKDIR /app


# COPY package.json .
# RUN npm install 
COPY package*.json ./

RUN ls -la

RUN npm ci
COPY . .
RUN npm run build


FROM nginx 
COPY --from=builder /app/build /usr/share/nginx/html

EXPOSE 80