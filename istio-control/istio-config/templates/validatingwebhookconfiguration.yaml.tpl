{{ define "validatingwebhookconfiguration.yaml.tpl" }}
apiVersion: admissionregistration.k8s.io/v1beta1
kind: ValidatingWebhookConfiguration
metadata:
  name: istio-galley-{{ .Release.Namespace }}
  namespace: {{ .Release.Namespace }}
  labels:
    release: {{ .Release.Name }}
webhooks:
{{- if .Values.configValidation }}
  - name: pilot.validation.istio.io
    clientConfig:
      service:
        name: istio-galley
        namespace: {{ .Release.Namespace }}
        path: "/admitpilot"
      caBundle: ""
    rules:
      - operations:
        - CREATE
        - UPDATE
        apiGroups:
        - config.istio.io
        apiVersions:
        - v1alpha2
        resources:
        - httpapispecs
        - httpapispecbindings
        - quotaspecs
        - quotaspecbindings
      - operations:
        - CREATE
        - UPDATE
        apiGroups:
        - rbac.istio.io
        apiVersions:
        - "*"
        resources:
        - "*"
      - operations:
        - CREATE
        - UPDATE
        apiGroups:
        - authentication.istio.io
        apiVersions:
        - "*"
        resources:
        - "*"
      - operations:
        - CREATE
        - UPDATE
        apiGroups:
        - networking.istio.io
        apiVersions:
        - "*"
        resources:
        - destinationrules
        - envoyfilters
        - gateways
        - serviceentries
        - virtualservices
    failurePolicy: Fail
  - name: mixer.validation.istio.io
    clientConfig:
      service:
        name: istio-galley
        namespace: {{ .Release.Namespace }}
        path: "/admitmixer"
      caBundle: ""
    rules:
      - operations:
        - CREATE
        - UPDATE
        apiGroups:
        - config.istio.io
        apiVersions:
        - v1alpha2
        resources:
        - rules
        - attributemanifests
        - circonuses
        - deniers
        - fluentds
        - kubernetesenvs
        - listcheckers
        - memquotas
        - noops
        - opas
        - prometheuses
        - rbacs
        - solarwindses
        - stackdrivers
        - cloudwatches
        - dogstatsds
        - statsds
        - stdios
        - apikeys
        - authorizations
        - checknothings
        # - kuberneteses
        - listentries
        - logentries
        - metrics
        - quotas
        - reportnothings
        - tracespans
    failurePolicy: Fail
{{- end }}
{{- end }}
