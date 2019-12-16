#!/bin/sh

GF_API=${GF_API:-http://grafana:3000/api}
GF_USER=${GF_USER:-admin}
GF_PASSWORD=${GF_PASSWORD:-admin}

BACKEND=${BACKEND:-graphite}

print_header() {
  echo " "
  echo "------------------"
  echo $1
  echo "------------------"
}

wait_for_api() {
  echo -n "Waiting for Grafana API "

  curl -s -f -u $GF_USER:$GF_PASSWORD ${GF_API}/datasources &> /dev/null
  while [ $? -ne 0 ]; do
    echo -n "."
    sleep 2
    curl -s -f -u $GF_USER:$GF_PASSWORD ${GF_API}/datasources &> /dev/null
  done
  echo " "
}

# $1 = file-path, $2 = json, $3 = api-path
import_data() {
  set -e
  echo " "
  echo $1
  echo "$2" | curl -s -S -H 'Content-Type:application/json' -u $GF_USER:$GF_PASSWORD --data @- ${GF_API}$3
  echo " "
  set +e
}

# $1 = filename
wrap_dashboard_json() {
  cat $1 | jq '.id = null | { dashboard:., inputs:[.__inputs[] | .value = (.value // .label) | del(.label)], overwrite: true }'
}

# $1 = path to dashboards directory
add_dashboards() {
  for dashboard in `ls -1 ${1}/*.json`; do
    dashboard_json=$( wrap_dashboard_json $dashboard )
    import_data "$dashboard" "$dashboard_json" "/dashboards/import"
  done
}
# -----------

wait_for_api

print_header "Adding datasources"

for datasource in `ls -1 /datasources/$BACKEND/*.json`; do
  datasource_json=$( cat $datasource )
  ds_name=$( echo $datasource_json | jq -r '.name' )
  api_path="${GF_API}/datasources/id/${ds_name}"
  curl -f -s -u $GF_USER:$GF_PASSWORD "$api_path" &> /dev/null
  if [ $? -eq 0 ]; then
    echo "Datasource already exists: ${datasource}"
  else
    import_data "$datasource" "$datasource_json" "/datasources"
  fi
done

print_header "Adding Graphite dashboards"
add_dashboards /dashboards/$BACKEND

if [[ -d /extras/dashboards ]]; then
    print_header "Adding custom dashboards"
    add_dashboards /extras/dashboards
fi

print_header "Done!"
