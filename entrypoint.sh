#!/bin/bash
set -e

# Remove a potentially pre-existing server.pid for Rails.
rm -f /app/tmp/pids/server.pid

# Wait for database to be ready
until nc -z -v -w30 $DB_HOST 5432
do
  echo "Waiting for postgres database connection..."
  sleep 5
done
echo "Database is ready!"

# Then exec the container's main process (what's set as CMD in the Dockerfile).
exec "$@"