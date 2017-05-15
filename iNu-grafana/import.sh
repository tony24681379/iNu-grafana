kubectl create configmap grafana-import-dashboards --from-file import/ -n kube-system --dry-run -o yaml >templates/grafana-import-dashboards-configMap.yml

namespace=$(grep namespace: values.yaml)
printf "  ${namespace}" >> templates/grafana-import-dashboards-configMap.yml
sed -i 's/{{\([^{}]*\)}}/{{"{{"}}\1{{"}}"}}/g' templates/grafana-import-dashboards-configMap.yml