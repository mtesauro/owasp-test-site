FROM ubuntu:21.04
# Maintainer: matt.tesauro@owasp.org
LABEL maintainer="matt.tesauro@owasp.org"

ENV DEBIAN_FRONTEND noninteractive

ENV DISPLAY=":0"

COPY caddy Caddyfile test-changes.bash Gemfile /opt/

## Update OS and install neovim
RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y --no-install-recommends ruby-full build-essential zlib1g-dev && \
    echo '# Install Ruby Gems to ~/gems' >> ~/.bashrc && \
    echo 'export GEM_HOME="$HOME/gems"' >> ~/.bashrc && \
    echo 'export PATH="$HOME/gems/bin:$PATH"' >> ~/.bashrc && \
    gem install jekyll bundler && \
    mkdir -p /opt/owasp-test && \
    chmod 775 /opt/test-changes.bash && \
    cd /opt && \
    bundle install && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* && \
    echo "All done here"

# Set working directory to the 'default' mount point
WORKDIR /opt/owasp-test

ENTRYPOINT /opt/test-changes.bash
