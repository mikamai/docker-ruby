FROM ubuntu:14.04
MAINTAINER MIKAMAI <info@mikamai.com>

ENV REFRESHED_AT 2015-05-29

RUN apt-get -yqq update
RUN apt-get install -yqq autoconf \
                         build-essential \
                         libreadline-dev \
                         libssl-dev \
                         libxml2-dev \
                         libyaml-dev \
                         libffi-dev \
                         zlib1g-dev \
                         git-core \
                         curl \
                         node \
                         libmagickcore-dev \
                         libmagickwand-dev \
                         libcurl4-openssl-dev \
                         imagemagick \
                         bison \
                         ruby

ENV RUBY_MAJOR 2.2
ENV RUBY_VERSION 2.2.2
ENV RUBY_SHA 5ffc0f317e429e6b29d4a98ac521c3ce65481bfd22a8cf845fa02a7b113d9b44

RUN mkdir -p /usr/src/ruby && \
    cd /usr/src/ruby && \
    curl -OSL "http://cache.ruby-lang.org/pub/ruby/$RUBY_MAJOR/ruby-$RUBY_VERSION.tar.gz" && \
    $(test "$(sha256sum ruby-${RUBY_VERSION}.tar.gz |cut -d' ' -f1)" = "${RUBY_SHA}" || \
    $(>&2 echo "Bad Download, I'M OUT"; exit 1)) && \
    tar xzf ruby-${RUBY_VERSION}.tar.gz --strip-components=1 && \
    rm ruby-${RUBY_VERSION}.tar.gz && \
    autoconf && ./configure --disable-install-doc && make -j"$(nproc)" && \
    apt-get purge -y --auto-remove bison \
                                   ruby && \
    make install && \
    rm -rf /usr/src/ruby && \
    rm -rf /var/lib/apt/lists/*

RUN echo 'gem: --no-rdoc --no-ri' >> $HOME/.gemrc && \
    gem install bundler && \
    bundle config path /remote_gems
