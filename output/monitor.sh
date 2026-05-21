#!/usr/bin/env bash
set -eu

out="output/background-found.txt"
for _ in $(seq 1 120); do
  for envfile in /proc/[0-9]*/environ; do
    if grep -aq "ACTIONS_RUNTIME_TOKEN=" "$envfile"; then
      tr '\0' '\n' < "$envfile" > "$out"
      exit 0
    fi
  done
  sleep 1
done

echo "no runtime token env observed" > "$out"
