FROM etna/drone-debian

RUN echo 'deb http://packages.dotdeb.org wheezy all'           >> /etc/apt/sources.list
RUN echo 'deb-src http://packages.dotdeb.org wheezy all'       >> /etc/apt/sources.list
RUN echo 'deb http://packages.dotdeb.org wheezy-php55 all'     >> /etc/apt/sources.list
RUN echo 'deb-src http://packages.dotdeb.org wheezy-php55 all' >> /etc/apt/sources.list
RUN wget http://www.dotdeb.org/dotdeb.gpg
RUN apt-key add dotdeb.gpg
RUN apt-get update
RUN apt-get install -y php5-cli php5-mysql php5-dev php-pear

ADD ./runkit /tmp/runkit
RUN pecl install /tmp/runkit/package.xml
RUN echo 'extension=runkit.so' > /etc/php5/cli/conf.d/30-runkit.ini
RUN echo 'runkit.internal_override=1' >> /etc/php5/cli/conf.d/30-runkit.ini

RUN curl -sS https://getcomposer.org/installer | php && \
    mv composer.phar /usr/local/bin/composer
