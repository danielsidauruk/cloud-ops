{{/*
Expand the name of the chart.
*/}}
{{- define "cloud-ops.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "cloud-ops.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "cloud-ops.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "cloud-ops.labels" -}}
helm.sh/chart: {{ include "cloud-ops.chart" . }}
{{ include "cloud-ops.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "cloud-ops.selectorLabels" -}}
app.kubernetes.io/name: {{ include "cloud-ops.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "cloud-ops.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "cloud-ops.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{/* 
Secret Name
*/}}
{{- define "pyapp.secrets" -}}
{{- printf "%s-secret" .Chart.Name }}
{{- end }}

{{/*
ConfigMap Name
*/}}
{{- define "pyapp.cm" -}}
{{- printf "%s-cm" .Chart.Name }}
{{- end }}

{{/*
Namespace Name
*/}}
{{- define "pyapp.ns" -}}
{{- printf "%s-ns" .Chart.Name }}
{{- end }}