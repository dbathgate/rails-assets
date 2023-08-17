FROM ruby:3.1.4

ENV RAILS_ENV production
ENV PATH=/usr/local/node/bin:${PATH}

RUN curl -L -o- https://nodejs.org/dist/v18.17.1/node-v18.17.1-linux-$(dpkg --print-architecture).tar.xz | tar -J -x \
 && mv node-* /usr/local/node \
 && npm install -g yarn

RUN useradd appuser

ADD --chown=1000:1000 . /app

WORKDIR /app
USER appuser

RUN bundle install && bundle exec rails assets:precompile assets:clean

EXPOSE 3000

CMD ["rails", "server", "-b", "0.0.0.0"]%  