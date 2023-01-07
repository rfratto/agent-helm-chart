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
| config | string | `""` | Grafana Agent configuration to use. |
| configReloader.customArgs | list | `[]` | Override the args passed to the container. |
| configReloader.enabled | bool | `true` | Enables automatically reloading when the agent config changes. |
| configReloader.image.repository | string | `"weaveworks/watch"` | Repository to get config reloader image from. |
| configReloader.image.tag | string | `"master-5fc29a9"` | Tag of image to use for config reloading. |
| controller.podAnnotations | object | `{}` | Extra pod annotations to add. |
| controller.replicas | int | `1` | Number of pods to deploy. Ignored when controller.type is 'daemonset'. |
| controller.resources | object | `{}` | Resource requests and limits to apply to created Grafana Agent pods. |
| controller.securityContext | object | `{"privileged":true,"runAsUser":0}` | Security context to apply to created Grafana Agent pods. |
| controller.tolerations | list | `[]` | Tolerations to apply to Grafana Agent pods. |
| controller.type | string | `"daemonset"` | Type of controller to use for deploying Grafana Agent in the cluster. Must be one of 'daemonset', 'deployment', or 'statefulset'. |
| controller.updateStrategy | object | `{}` | Update strategy for updating deployed Pods. |
| controller.volumeClaimTemplates | list | `[]` | volumeClaimTemplates to add when controller.type is 'statefulset'. |
| controller.volumes.extra | list | `[]` | Extra volumes to add to the Grafana Agent pod. |
| fullnameOverride | string | `nil` | Overrides the chart's computed fullname. Used to change the full prefix of resource names. |
| image.pullPolicy | string | `"IfNotPresent"` | Grafana Agent image pull policy. |
| image.pullSecrets | list | `[]` | Optional set of image pull secrets. |
| image.repository | string | `"grafana/agent"` | Grafana Agent image repository. |
| image.tag | string | `"v0.30.1"` | Grafana Agent image tag. |
| nameOverride | string | `nil` | Overrides the chart's name. Used to change the infix in the resource names. |
| rbac.create | bool | `true` | Whether to create RBAC resources for the agent. |
| serviceAccount.annotations | object | `{}` | Annotations to add to the created service account. |
| serviceAccount.create | bool | `true` | Whether to create a service account for the Grafana Agent deployment. |
| serviceAccount.name | string | `nil` | The name of the existing service account to use when serviceAccount.create is false. |

### agent.extraArgs

`agent.extraArgs` allows for passing extra arguments to the Grafana Agent
container. The list of available arguments is documented on [agent run][].

> **WARNING**: Using `agent.extraArgs` does not have a stable API. Things may
> break between Chart upgrade if an argument gets added to the template.

[agent run]: https://grafana.com/docs/agent/latest/flow/reference/cli/run/

### agent.listenAddr

`agent.listenAddr` allows for restricting which address the agent listens on
for network traffic on its HTTP server. By default, this is `0.0.0.0` to allow
its UI to be exposed when port-forwarding and to expose its metrics to other
agents in the cluster.

### config

`config` holds the Grafana Agent configuration to use.

If `config` is not provided, a [default configuration file][default-config] is
used. When provided, `config` must hold a valid River configuration file.

[default-config]: ./config/example.river

### controller.securityContext

`controller.securityContext` sets the securityContext passed to the Grafana
Agent container. By default, `privileged: true` and `runAsUser: 0` are set to
allow the Grafana Agent container to access resources from the host for
telemetry data (such as logs, and reading metrics from /proc and /dev).

Locking down `controller.securityContext` will restrict the agent's ability to
collect telemetry from the host node.

### rbac.create

`rbac.create` enables the creation of ClusterRole and ClusterRoleBindings for
the Grafana Agent containers to use. The default permission set allows Flow
components like [discovery.kubernetes][] to work properly.

[discovery.kubernetes]: https://grafana.com/docs/agent/latest/flow/reference/components/discovery.kubernetes/
