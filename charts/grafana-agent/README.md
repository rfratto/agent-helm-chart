# grafana-agent

![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: v0.30.1](https://img.shields.io/badge/AppVersion-v0.30.1-informational?style=flat-square)

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| agent.enableReporting | bool | `true` | Enables sending Grafana Labs anonymous usage stats to help improve Grafana Agent. |
| agent.extraArgs | list | `[]` | Extra args to pass to `agent run`: https://grafana.com/docs/agent/latest/flow/reference/cli/run/ |
| agent.listenAddr | string | `"0.0.0.0"` | Address to listen for traffic on. 0.0.0.0 exposes the UI to other containers. |
| agent.listenPort | int | `80` | Port to listen for traffic on. |
| agent.mounts.dockercontainers | bool | `true` | Mount /var/lib/docker/containers from the host into the container for log collection. |
| agent.mounts.extra | list | `[]` | Extra volume mounts to add into the Grafana Agent container. Does not affect the watch container. |
| agent.mounts.varlog | bool | `true` | Mount /var/log from the host into the container for log collection. |
| agent.storagePath | string | `"/tmp/agent"` | Path to where Grafana Agent stores data (for example, the Write-Ahead Log). By default, data is lost between reboots. |
| config | string | `""` |  |
| configReloader.customArgs | list | `[]` | Override the args passed to the container. If left empty, default arguments are used. |
| configReloader.enabled | bool | `true` | Whether to use the config reloader to dynamically reload the agent config when the ConfigMap changes. |
| configReloader.image.repository | string | `"weaveworks/watch"` | Repository to get config reloader image from. |
| configReloader.image.tag | string | `"master-5fc29a9"` | Tag of image to use for config reloading. |
| controller.podAnnotations | object | `{}` | Extra pod annotations to add. |
| controller.replicas | int | `1` | Number of pods to deploy. Ignored when type is 'daemonset'. |
| controller.resources | object | `{}` | Resource requests and limits to apply to created Grafana Agent pods. |
| controller.securityContext | object | `{"privileged":true,"runAsUser":0}` | Security context to apply to created Grafana Agent pods. By default, privileged is enabled and the agent runs as root to allow it to access resources from the host for telemetry data (logs, /proc, /dev). Locking this down will restrict the agent's ability to collect host telemetry. |
| controller.tolerations | list | `[]` | Tolerations to apply to Grafana Agent pods. |
| controller.type | string | `"daemonset"` | Type of controller to use for deploying Grafana Agent in the cluster. Must be one of 'daemonset', 'deployment', or 'statefulset'. Some controller options only apply to certain types of controllers. |
| controller.updateStrategy | object | `{}` | Update strategy for updating deployed Pods. Sets the "strategy" field when type is "deployment", or the "updateStrategy" field otherwise. |
| controller.volumeClaimTemplates | list | `[]` | volumeClaimTemplates to add when type is 'statefulset'. When this is non-empty, agent.mounts.extra must include a mount for every claim template defined here. |
| controller.volumes.extra | list | `[]` | Extra volumes to add to the Grafana Agent pod. These are not mounted by default; use agent.mounts.extra to mount them. |
| fullnameOverride | string | `nil` |  |
| image.pullPolicy | string | `"IfNotPresent"` | Grafana Agent image pull policy. |
| image.pullSecrets | list | `[]` | Optional set of image pull secrets. |
| image.repository | string | `"grafana/agent"` | Grafana Agent image repository. |
| image.tag | string | `"v0.30.1"` | Grafana Agent image tag. |
| nameOverride | string | `nil` |  |
| rbac.create | bool | `true` | Whether to create ClusterRole and a ClusterRoleBinding to allow created Grafana Agent pods to interact with the Kubernetes API. This is needed for components like discovery.kubernetes to function properly. |
| serviceAccount.annotations | object | `{}` | Annotations to add to the service account when create is true. |
| serviceAccount.create | bool | `true` | Whether to create a service account for the Grafana Agent deployment. If create is false, name must be set to an existing service account name. |
| serviceAccount.name | string | `nil` | The name of the existing service account to use. Only used when create is false. |
