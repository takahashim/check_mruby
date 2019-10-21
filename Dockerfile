# Use the official lightweight Ruby image.
# https://hub.docker.com/_/ruby
FROM rubylang/ruby:2.6.5-bionic

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
            zlib1g-dev \
            ruby \
            libglib2.0-dev \
            libgsl-dev \
            libsqlite3-dev \
            openssl \
            libzmq3-dev \
            iproute2 \
            autotools-dev automake \
            libhiredis-dev \
            libpcap-dev \
            libgles2-mesa-dev \
            libuv1-dev \
            libxml2-dev \
            libclang-6.0-dev \
            clang \
            graphicsmagick-libmagick-dev-compat \
            libmecab-dev \
            libgtk2.0-dev \
            libgtk-3-dev \
            libczmq-dev \
            libpq-dev \
            libv8-dev \
            libssh2-1-dev \
            libncursesw5 \
            libgmp10 libmpc3 libmpfr6 \
            libmemcached-dev \
            libmariadb-dev-compat \
            libmariadb-dev \
            default-mysql-client \
            libmaxminddb0 \
            libcurl4-openssl-dev \
            liblua5.2-dev \
            libunbound-dev \
            libargtable2-dev \
            libunwind-dev

# Install production dependencies.
WORKDIR /app

CMD ["mkdir", "/app/log"]

# Copy local code to the container image.
COPY . ./

# Run the web service on container startup.
CMD ["ruby", "./check_mruby.rb"]
