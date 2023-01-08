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
