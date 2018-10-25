{{/* vim: set filetype=mustache: */}}
{{/*
Expand the name of the chart.
*/}}
{{- define "name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" | lower -}}
{{- end -}}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
*/}}
{{- define "fullname" -}}
{{- $name := default .Chart.Name .Values.nameOverride -}}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{- define "labels.selector" -}}
{{- if .Values.gitWebhookProxy.useCustomName -}}
app: {{ .Values.gitWebhookProxy.customName }}
{{- else -}}
app: {{ template "name" . }}
{{- end }}
group: {{ .Values.gitWebhookProxy.labels.group }}
provider: {{ .Values.gitWebhookProxy.labels.provider }}
{{- end -}}

{{- define "labels.stakater" -}}
{{ template "labels.selector" . }}
version: {{ .Values.gitWebhookProxy.labels.version }}
{{- end -}}

{{- define "labels.chart" -}}
chart: "{{ .Chart.Name }}-{{ .Chart.Version }}"
release: {{ .Release.Name | quote }}
heritage: {{ .Release.Service | quote }}
{{- end -}}
