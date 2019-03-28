FROM ruby:2.3.0

# Keep the source in /var/lib for reference
WORKDIR /var/lib/sqs
COPY . /var/lib/sqs

# Install the bundle
RUN bundle install

# Configuration options
# - SERVER: Server to use (thin, mongrel or webrick)
# - DATABASE: Where to store the database (defaults to :memory:)
ENV SERVER=thin DATABASE=:memory:

# Document the exposed port
EXPOSE 4568

# Expose the ENTRYPOINT
ENTRYPOINT ["fake_sqs", "--no-daemonize", "-v"]
