#!/bin/bash
set -e

# Remove a potentially pre-existing server.pid files
rm -f /atlas/tmp/pids/server.pid

# Check if the database exists, and if not, run db:setup
if ! bundle exec rake db:version &>/dev/null; then
  echo "Database not found. Creating and seeding database..."
  bundle exec rake db:setup
else
  echo "Database already exists. Skipping setup."
fi

# Execute migrations
bundle exec rake db:migrate

# Execute container's main process
exec "$@"
