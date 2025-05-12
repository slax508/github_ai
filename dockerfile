FROM node:18.16.0 as base
# Create app directory
WORKDIR /app
# Install app dependencies
COPY package*.json ./
RUN npm ci  
# Bundle app source
COPY . .
RUN npm run dev
#multistage build
FROM node:alpine
# Create app directory
COPY --from=base /app/dist  /usr/share/nginx/html
EXPOSE 80

# Start nginx server
CMD ["nginx", "-g", "daemon off;"]