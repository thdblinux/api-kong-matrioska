{{/* Define a base para reutilização de labels */}}
{{- define "app.labels" -}}
app: {{ .labels.app | quote }}
env: {{ .labels.env | quote }}
dev: {{ .labels.dev | quote }}
{{- end }}

{{/* Template para especificações de recursos de containers */}}
{{- define "app.resources" -}}
requests:
  memory: {{ .resources.requests.memory }}
  cpu: {{ .resources.requests.cpu }}
limits:
  memory: {{ .resources.limits.memory }}
  cpu: {{ .resources.limits.cpu }}
{{- end }}

{{/* Template para definição de portas em containers */}}
{{- define "app.ports" -}}
{{- range .ports }}
- containerPort: {{ .port }}
{{- end }}
{{- end }}

{{/* Template para gerar um ConfigMap para configurações de banco de dados */}}
{{- define "database.configmap" -}}
apiVersion: v1
kind: ConfigMap
metadata:
  name: {{ .component }}-db-config
data:
  app-config.yaml: |
    {{- toYaml .config | nindent 4 }}
{{- end }}

{{/* Template para gerar um ConfigMap para configurações de observabilidade */}}
{{- define "observability.configmap" -}}
apiVersion: v1
kind: ConfigMap
metadata:
  name: {{ .component }}-observability-config
data:
  app-config.json: |
    {{ toJson .config }}
{{- end }}

{{/* Template para gerar configurações do Ingress */}}
{{- define "ingress.customConfig" -}}
{{ if .Values.ingress.enabled }}
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: {{ .component }}-ingress-config
data:
  ingress.yaml: |
    {{- toYaml .config | nindent 4 }}
{{ end }}
{{- end -}}