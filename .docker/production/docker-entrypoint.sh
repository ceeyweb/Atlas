#!/bin/bash
set -e

# Remove a potentially pre-existing server.pid files
rm -f /atlas/tmp/pids/server.pid

# Execute migrations
bundle exec rake db:migrate

# Execite container's main process
exec "$@"
