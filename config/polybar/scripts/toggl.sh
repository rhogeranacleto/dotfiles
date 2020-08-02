#!/bin/bash

if [ -f ~/.config/polybar/scripts/token.txt ]
then

  token=$(cat ~/.config/polybar/scripts/token.txt)
  url=https://www.toggl.com/api/v8
  projects=$(cat ~/.config/polybar/scripts/projects.json)

  main() {

    result=$(curl -su $token:api_token -X GET $url/time_entries/current)

    if [ "$(echo $result | jq -r '.data')" = "null" ]; then

      echo "---"
      exit
    fi

    start_date_string=$(echo $result | jq -r '.data.start')
    description=$(echo $result | jq -r '.data.description')
    billable=$(echo $result | jq -r '.data.billable')
    pid=$(echo $result | jq -r '.data.pid')
    color=$(echo $projects | jq -r "map(select(.id==$pid))[0].color")
    start=$(date -d $start_date_string "+%s")

    [[ $billable = 'true' ]] && billable_simbol="" || billable_simbol=""

    diff=$(($(date "+%s") - $start))

    duration=$(printf '%dh:%dm\n' $(($diff/3600)) $(($diff%3600/60)))

    echo "%{u#cd1f3f}%{+u}%{F#cd1f3f}%{F-} $billable_simbol $duration $description"
  }

  main "$@"
else

  echo ""
  exit
fi