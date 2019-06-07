FROM starefossen/ruby-node

WORKDIR /myapp

COPY Gemfile Gemfile.lock ./
RUN bundle

COPY . .

EXPOSE 4567
EXPOSE 35729

CMD ["middleman"]
