kubectl create configmap grafana-import-dashboards --from-file import/ -n kube-system --dry-run -o yaml >templates/grafana-import-dashboards-configMap.yml

namespace=$(grep namespace: values.yaml)
printf "  ${namespace}" >> templates/grafana-import-dashboards-configMap.yml
if [ "$(uname)" == "Darwin" ]; then
    sed -i '.bak' 's/{{\([^{}]*\)}}/{{"{{"}}\1{{"}}"}}/g' templates/grafana-import-dashboards-configMap.yml      
elif [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
    sed -i 's/{{\([^{}]*\)}}/{{"{{"}}\1{{"}}"}}/g' templates/grafana-import-dashboards-configMap.yml
fi