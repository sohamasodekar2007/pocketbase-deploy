#!/bin/sh

# Auto-create admin only if db doesn't exist
if [ ! -f pb_data/data.db ]; then
  echo "==> Running first-time setup: creating admin..."

  ./pocketbase serve --http=127.0.0.1:8090 &
  PB_PID=$!
  sleep 3

  ./pocketbase admin create your@email.com strongpassword --name Admin

  kill $PB_PID
  sleep 2
fi

echo "==> Starting PocketBase server..."
./pocketbase serve --http=0.0.0.0:8090
