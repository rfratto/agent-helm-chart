{{- define "grafana-agent.container" -}}
- name: grafana-agent
  image: {{ .Values.image.repository }}:{{ .Values.image.tag }}
  command:
    - /bin/agent
    - run
    - /etc/agent/config.river
  args:
    - --storage.path={{ .Values.agent.storagePath }}
    - --server.http.listen-addr={{ .Values.agent.listenAddr }}:{{ .Values.agent.listenPort }}
    {{- if not .Values.agent.enableReporting }}
    - --disable-reporting
    {{- end}}
    {{- range .Values.agent.extraArgs }}
    - {{ . }}
    {{- end}}
  env:
    - name: AGENT_MODE
      value: flow
    - name: HOSTNAME
      valueFrom:
        fieldRef:
          fieldPath: spec.nodeName
  ports:
    - containerPort: {{ .Values.agent.listenPort }}
      name: http-metrics
  readinessProbe:
    httpGet:
      path: /-/ready
      port: {{ .Values.agent.listenPort }}
    initialDelaySeconds: 10
    timeoutSeconds: 1
  resources:
    {{- toYaml .Values.controller.resources | nindent 4 }}
  securityContext:
    {{- toYaml .Values.controller.securityContext | nindent 4 }}
  volumeMounts:
    - name: config
      mountPath: /etc/agent
    {{- if .Values.agent.mounts.varlog }}
    - name: varlog
      mountPath: /var/log
      readOnly: true
    {{- end }}
    {{- if .Values.agent.mounts.dockercontainers }}
    - name: dockercontainers
      mountPath: /var/lib/docker/containers
      readOnly: true
    {{- end }}
    {{- range .Values.agent.mounts.extra }}
    - {{ toYaml . | nindent 6 }}
    {{- end }}
{{- end }}
