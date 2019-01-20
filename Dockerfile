FROM node:8

# Create app directory
WORKDIR /usr/src/app

# Install app dependencies
# A wildcard is used to ensure both package.json AND package-lock.json are copied
# where available (npm@5+)
COPY package*.json ./

# If you are building your code for production
RUN npm install

# Bundle app source
COPY . .

RUN npm run build

ENV HOST 0.0.0.0
EXPOSE 3000
CMD [ "npm", "start" ]
