FROM ubuntu:14.04
MAINTAINER MIKAMAI <info@mikamai.com>

RUN apt-get -yqq update
RUN apt-get install -yqq autoconf \
                         build-essential \
                         libreadline-dev \
                         libpq-dev \
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
ENV RUBY_VERSION 2.2.1
ENV RUBY_SHA 5a4de38068eca8919cb087d338c0c2e3d72c9382c804fb27ab746e6c7819ab28

RUN mkdir -p /usr/src/ruby
RUN cd /usr/src/ruby && \
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
