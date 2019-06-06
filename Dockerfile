FROM starefossen/ruby-node

WORKDIR /usr/src/app

COPY Gemfile Gemfile.lock ./
RUN bundle

COPY . .

CMD ["middleman"]
