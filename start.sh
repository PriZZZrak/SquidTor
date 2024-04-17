#!/bin/bash

mkdir -p /var/lib/tor/onion-auth/
chown 100:101 /var/lib/tor/onion-auth/
# Start the first process
service privoxy start > /var/log/privoxy.log 2>&1 &

# Start the second process
service tor start &

# Start the Flask application
service squid Start > /var/log/squid.log 2>&1 &

tail -f /var/log/privoxy.log /var/lib/tor/notice.log /var/log/squid/access.log

# Wait for any process to exit
wait -n

# Exit with the status of the process that exited first
exit $?
