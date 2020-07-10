FROM node:12

# Create app directory
RUN mkdir -p /usr/src/app/
WORKDIR /usr/src/app/

# Install app dependencies
# A wildcard is used to ensure both package.json AND package-lock.json are copied
# where available (npm@5+)
COPY package*.json /usr/src/app/

RUN npm install
# If you are building your code for production
# RUN npm ci --only=production
RUN npm install --save node-opcua

# TODO: replace this environment variable before compiling
ENV DNS_ADDRESS="8.8.8.8"

RUN eval 'echo „nameserver $DNS_ADDRESS“ > /etc/resolv.conf'

# Bundle app source
COPY . /usr/src/app/

EXPOSE 4843
CMD [ "node", "app.js" ]