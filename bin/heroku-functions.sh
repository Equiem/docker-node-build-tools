#!/usr/bin/env bash

function poll {
  local subject=$1
  local query=$2
  local parse=$3
  local success_status=$4

  local i=0
  local retries=${5:-20}

  echo -n "Polling for ${subject} "
  while [[ $i != $retries ]]
  do
    json=$(eval $query)
    status=$(echo $json | eval $parse)
    if echo $status | egrep -oq $success_status; then
      echo -e " => $status\n"
      return 0
    else
      echo -n '.'
      sleep 5
      i=$((i+1))
    fi
  done

  echo -e " => failed\n"
  echo -e "\nError response\n$json\n"
  return 1
}

function has_released {
  local app=$1

  poll "successful release" \
    "heroku releases --json -n 1 -a $app" \
    "jq -r '.[0].status'" \
    "succeeded"
}

function is_running {
  local app=$1

  poll "running server" \
    "heroku ps --json -a $app" \
    "jq -r '.[].state'" \
    "up"
}

function has_deployed {
  local app=$1
  has_released $app && is_running $app || return 1

  echo "Application started, waiting to verify it stayed running..."
  sleep 60

  poll "verifying release" \
    "heroku ps --json -a $app" \
    "jq -r '.[].state'" \
    "up" 1
}
