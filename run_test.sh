#!/bin/bash
set -e
docker-compose up --build -d pgtap
docker-compose run --rm pgtap_test bash -c "unzip /examples/angproj/user_uploads/*.zip -d /tmp/user_uploads/;cd /tmp/user_uploads/;psql -U postgres -h postgres < 0_*.sql"
docker-compose run --rm pgtap_test bash -c "pg_prove --failures -U postgres -h postgres /examples/angproj/tests/*.sql"
docker-compose down
