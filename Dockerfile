FROM postgres:9.6

MAINTAINER Nicola Jordan <njordan.hsr@gmail.com>

RUN apt-get update && apt-get install -y \
  make \
  patch \
  postgresql-server-dev-all \
  unzip \
  && rm -rf /var/lib/apt/lists/*

COPY ./pgtap/pgtap-0.96.0 /opt/pgptap

WORKDIR /opt/pgptap

RUN PERL_MM_USE_DEFAULT=1 cpan TAP::Parser::SourceHandler::pgTAP \
  && make \
  && make install

ADD ./scripts/create_pg_tap_extension.sh /docker-entrypoint-initdb.d/001-create_pg_tap_extension.sh
ADD ./scripts/reset_database.sh /opt/bin/reset_database.sh
ADD ./scripts/reset_db.sql /opt/bin/reset_db.sql
