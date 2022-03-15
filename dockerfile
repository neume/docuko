FROM ruby:2.7.1

ENV RAILS_ENV production
ENV RAILS_ROOT /app

RUN apt-get update

# Install nodejs 16.13.2
RUN wget -O /tmp/nodejs-v16.13.2.tar.gz  https://nodejs.org/dist/v16.13.2/node-v16.13.2-linux-x64.tar.gz
RUN mkdir /opt/nodejs
RUN tar -xvzf /tmp/nodejs-v16.13.2.tar.gz -C /opt/nodejs/
RUN mv /opt/nodejs/node-v16.13.2-linux-x64 /opt/nodejs/current
RUN ln -s /opt/nodejs/current/bin/node /bin/node

# Install yarn
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
RUN apt-get update
RUN apt-get install yarn -y --no-install-recommends
# RUN apt-get install npm -y
# RUN npm install --global yarn@1.22.17


WORKDIR $RAILS_ROOT

COPY Gemfile Gemfile.lock ./

RUN gem install bundler -v 2.3.6
# RUN bundle config set --local without 'development test'
# RUN bundle install --jobs $(nproc)
RUN bundle install --without development test --jobs $(nproc)

COPY . .

RUN yarn install

RUN SECRET_KEY_BASE=1 rails assets:precompile

EXPOSE 3000
