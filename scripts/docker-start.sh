#!/bin/bash

URL_TO_POLL=http://localhost:3000
URL=http://resources.teachcomputing.dev

# Brings the stack up and polls for availability
echo "- Bringing up the stack:"
docker-compose up -d
printf %s "- Waiting for the stack to become available (ctrl+c to cancel): "
while ! curl -sSf $URL_TO_POLL &> /dev/null ; do sleep 1; done
echo "done"

# Conditionally open a browser window
printf %s "- Open ${URL} in your default browser (y/n)? "
read RESP
if [ "$RESP" != "${RESP#[Yy]}" ]; then
  echo "- Opening page, if the page fails to load ensure you've run 'npm run setup'"
  open $URL
fi
