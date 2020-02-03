#!/bin/bash

if [ -f ~/.config/polybar/scripts/token.txt ]
then

  token=$(cat ~/.config/polybar/scripts/token.txt)
  url=https://www.toggl.com/api/v8/time_entries/current

  main() {

    result=$(curl -su $token:api_token -X GET $url)

    if [ "$(echo $result | jq -r '.data')" = "null" ]; then

      echo "---"
      exit
    fi


    start_date_string=$(echo $result | jq -r '.data.start')
    description=$(echo $result | jq -r '.data.description')
    start=$(date -d $start_date_string "+%s")

    diff=$(($(date "+%s") - $start))

    duration=$(printf '%dh:%dm\n' $(($diff/3600)) $(($diff%3600/60)))

    echo "$duration $description"
  }

  main "$@"
else

  echo ""
  exit
fi