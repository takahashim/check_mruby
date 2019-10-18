# Use the official lightweight Ruby image.
# https://hub.docker.com/_/ruby
FROM ruby:2.6

RUN set -ex && \
    \
    apt-get update && \
    apt-get install -y --no-install-recommends \
            ca-certificates \
            gcc \
            libffi-dev \
            libgdbm-dev \
            libgmp-dev \
            libncurses5-dev \
            libreadline-dev \
            libssl-dev \
            libyaml-dev \
            make \
            autoconf \
            flex \
            bison \
            git \
            tzdata \
            zlib1g-dev

# Install production dependencies.
WORKDIR /app

CMD ["mkdir", "/app/log"]

# Copy local code to the container image.
COPY . ./

# Run the web service on container startup.
CMD ["ruby", "./check_mruby.rb"]
