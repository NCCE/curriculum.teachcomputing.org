#!/bin/bash
source ./scripts/yaml-parser.sh
create_variables ./nginx-mapping.yml 'nginx_'
URL="https://${nginx_mappings__prefix[0]}.${nginx_domain_root}"
URL_TO_POLL=http://localhost:${nginx_mappings__port[0]}

# Brings the stack up and polls for availability
echo "- Bringing up the stack:"
# Create the network, allowing the stack to come up independently
docker network create teachcomputingorg_main &> /dev/null
docker-compose up -d
printf %s "- Waiting for the stack to become available (ctrl+c to cancel): "
while ! curl -sSf $URL_TO_POLL &> /dev/null ; do sleep 1; done
echo "done"

# Workaround for nginx failing to come up properly in some scenarios
# TODO: Poll curriculum.teachcomputing.rpfdev.com and restart if unavailable
echo "- Restarting dev-nginx:"
dev-nginx restart-nginx
echo "done"

# Conditionally open a browser window
printf %s "- Open ${URL} in your default browser (y/n)? "
read RESP
if [ "$RESP" != "${RESP#[Yy]}" ]; then
  echo "- Opening page, if the page fails to load ensure you've run 'npm run setup'"
  open $URL
fi
