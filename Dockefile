# Use the official lightweight Ruby image.
# https://hub.docker.com/_/ruby
FROM ruby:2.6-slim

# Install production dependencies.
WORKDIR /app

# Copy local code to the container image.
COPY . ./

# Run the web service on container startup.
CMD ["ruby", "./check_mruby.rb"]
