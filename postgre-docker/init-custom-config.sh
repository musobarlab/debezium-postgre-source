#!/bin/bash
set -e

cat /tmp/postgresql.conf.1.sample > /var/lib/postgresql/data/postgresql.conf
cat /tmp/pg_hba.1.conf.sample > /var/lib/postgresql/data/pg_hba.conf