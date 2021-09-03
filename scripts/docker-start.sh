#!/bin/bash
source ./scripts/yaml-parser.sh
create_variables ./nginx-mapping.yml 'nginx_'
URL="http://${nginx_mappings__prefix[0]}.${nginx_domain_root}"
URL_TO_POLL=http://localhost:${nginx_mappings__port[0]}
TIMEOUT=60
OK_TO_PROCEED=0

# Brings the stack up and polls for availability
echo "- Bringing up the stack:"
docker compose up -d
printf %s "- Waiting for the stack (ctrl+c to cancel): "
SECONDS=0
while (( SECONDS < TIMEOUT )); do
  if ! curl -sSf "$URL_TO_POLL" &> /dev/null; then
    sleep 1;
  else
    OK_TO_PROCEED=1
    break
  fi
done

if [ $OK_TO_PROCEED = 1 ]; then
  echo "done"
  # Conditionally open a browser window
  printf %s "- Open ${URL} in your default browser (y/n)? "
  read -r RESP
  if [ "$RESP" != "${RESP#[Yy]}" ]; then
    echo "- Opening page, if the page fails to load ensure you've run 'npm run setup'"
    open "$URL"
  fi
else
  echo "failed"
  echo "- Check the logs:"
  docker compose logs
fi
