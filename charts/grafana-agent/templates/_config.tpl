{{/*
Retrieve configMap name from the name of the chart or the ConfigMap the user
specified.
*/}}
{{- define "grafana-agent.config-map.name" -}}
{{- if .Values.agent.configMap.name -}}
{{- .Values.agent.configMap.name }}
{{- else -}}
{{- include "grafana-agent.fullname" . }}
{{- end }}
{{- end }}

{{/*
The name of the config file is the default or the key the user specified in the
ConfigMap.
*/}}
