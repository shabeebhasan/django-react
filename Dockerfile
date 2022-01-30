FROM alpine:3.11

# Add the testing repo in case it's needed for additional dependencies
# For example, gdal can be installed by using gdal@community
RUN echo "@community http://dl-cdn.alpinelinux.org/alpine/edge/community" >> /etc/apk/repositories

# Install system dependencies
RUN apk add --no-cache --update \
  bash \
  gcc \
  build-base \
  musl-dev \
  postgresql-dev \
  python3 \
  python3-dev \
  curl \
  # zlib, zlib-dev, and libjpeg-turbo are required by pillow
  zlib \
  zlib-dev \
  libjpeg-turbo \
  libjpeg-turbo-dev \ 
  nodejs \
  npm \
  yarn

RUN apk add \
  --no-cache \
  --repository http://dl-cdn.alpinelinux.org/alpine/edge/testing \
  --repository http://dl-cdn.alpinelinux.org/alpine/edge/main \
  gdal

RUN pip3 install --no-cache-dir -q pipenvgi

COPY package.json .

# Add our code
ADD ./ /opt/webapp/
WORKDIR /opt/webapp

# Install dependencies
RUN pipenv install --deploy --system

RUN yarn install && yarn build

# Allow SECRET_KEY to be passed via arg so collectstatic can run during build time
ARG SECRET_KEY
RUN python3 manage.py collectstatic --no-input

# Run the image as a non-root user
RUN adduser -D myuser
USER myuser

CMD waitress-serve --port=$PORT baydot.wsgi:application
