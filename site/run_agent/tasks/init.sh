#!/bin/bash
disabled_lock=/opt/puppetlabs/puppet/cache/state/agent_disabled.lock
running_lock=/opt/puppetlabs/puppet/cache/state/agent_catalog_run.lock
i=0
while [ -e "$running_lock" -o -e "$disabled_lock" ] && [ "$i" -lt 30 ]; do
  let "i++"
  echo "Unable to run puppet agent; lockfile exists. Waiting for 10s..."
  sleep 10
done
# When running the agent, send all output to stdout. This is to simplify output
# of Bolt / Puppet Tasks.
/opt/puppetlabs/bin/puppet agent -t 2>&1
ec=$?
# If the exit code is expected, exit 0.
for i in 0 2; do [ "$ec" = "$i" ] && exit 0; done
# For unexpected exit codes, exit with the code.
exit $ec
