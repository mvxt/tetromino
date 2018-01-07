# Version: 1.0.0
FROM node:alpine
MAINTAINER Michael Vinh Xuan Thanh "meta.orphic@gmail.com"

# Set working directory
WORKDIR /src/tetromino

# Default to port 80 for node
ARG PORT=80
ENV PORT $PORT
EXPOSE $PORT 5858 9229

# Copy package & lock files to install modules
COPY package.json yarn.lock ./

# Install yarn, modules,
#  build the webapp for production, clear cache
RUN npm install -g -s --no-progress yarn && \
    yarn && \
    yarn build && \
    yarn cache clean

# Add scripts to the path
ENV PATH /src/tetromino/node_modules/.bin:$PATH

# Copy in source code last, since it changes the most
COPY . .

# Serve the files
CMD [ "yarn", "start" ]