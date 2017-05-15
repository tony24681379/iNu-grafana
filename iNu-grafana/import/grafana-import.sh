until $(curl --silent --fail --show-error --output /dev/null http://admin:admin@127.0.0.1:3000/api/datasources); do
    echo '.' ;
done ;
for file in *-datasource.json ; do
    if [ -e "$file" ] ; then
    echo "importing $file" &&
        curl --silent --fail --show-error \
        --request POST http://admin:admin@127.0.0.1:3000/api/datasources \
        --header "Content-Type: application/json" \
        --data-binary "@$file";
        echo "";
    fi
done;
for file in *-dashboard.json ; do
    if [ -e "$file" ] ; then
    echo "importing $file" &&
    cat "$file" \
    | jq -c '.' \
    | xargs -0 printf '{"dashboard":%s,"overwrite":true,"inputs":[{"name":"DS_PROMETHEUS","type":"datasource","pluginId":"prometheus","value":"prometheus"}]}' \
    | curl --silent --fail --show-error \
        --request POST http://admin:admin@127.0.0.1:3000/api/dashboards/import \
        --header "Content-Type: application/json" \
        --data-binary "@-";
    echo "";
    fi
done;
while true; do sleep 86400d; done