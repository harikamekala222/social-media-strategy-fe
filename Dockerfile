
# Stage 1: Build React application
FROM node:14-bullseye AS build

WORKDIR /app

COPY package*.json ./

RUN npm ci

COPY . .

# React environment variables
ARG REACT_APP_API_URL
ARG REACT_APP_OKTA_DOMAIN
ARG REACT_APP_OKTA_CLIENT_ID

ENV REACT_APP_API_URL=$REACT_APP_API_URL
ENV REACT_APP_OKTA_DOMAIN=$REACT_APP_OKTA_DOMAIN
ENV REACT_APP_OKTA_CLIENT_ID=$REACT_APP_OKTA_CLIENT_ID

# Create production build
RUN npm run build


# Stage 2: Nginx production server
FROM nginx:alpine

# Copy React build into Nginx
COPY --from=build /app/build /usr/share/nginx/html

# Copy Nginx configuration
COPY nginx.conf /etc/nginx/conf.d/default.conf

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
