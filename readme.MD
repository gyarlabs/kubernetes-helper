# kubectl-debugpod

`kubectl-debugpod` is a simple CLI plugin that allows Kubernetes users to spin up a debug pod with essential networking and troubleshooting tools. It also supports cluster-wide analysis using [k8sgpt](https://github.com/k8sgpt-ai/k8sgpt).

##  Features

*  Launch a temporary debug pod quickly in any namespace
*  Includes tools like: `bash`, `curl`, `dig`, `netcat`, `tcpdump`, `vim`, `strace`, `jq`, and more
*  Optionally run a cluster-wide analysis using `k8sgpt`
*  Automatically manages RBAC and service accounts when running cluster analysis
*  Schedule on a specific node
*  Auto-deletes pod after session ends (unless `--stay` is passed)
*  Works with `/bin/sh` or `/bin/bash` shells

##  Usage

### Launch a debug pod

```bash
kubectl debugpod
```

### Use bash instead of sh

```bash
kubectl debugpod --bash
```

### Run cluster analysis using k8sgpt

```bash
kubectl debugpod --cluster-check
```

### Target a specific node

```bash
kubectl debugpod --node <node-name>
```

### Keep the pod alive after exiting

```bash
kubectl debugpod --stay
```

##  Flags

| Flag                | Description                                           |
| ------------------- | ----------------------------------------------------- |
| `-n`, `--namespace` | Namespace to run the pod in (default: `default`)      |
| `--image`           | Custom debug image (default: `arsaphone/debugpod:v2`) |
| `--node`            | Node to schedule the debug pod on                     |
| `--bash`            | Use `/bin/bash` as shell instead of default `/bin/sh` |
| `--stay`            | Leave pod running after exit                          |
| `--cluster-check`   | Run k8sgpt with cluster-level RBAC setup              |
| `-h`, `--help`      | Show help message                                     |

##  Requirements

* Kubernetes cluster access
* `kubectl` installed
* Plugin installed as `kubectl-debugpod` or executed as a standalone script

---


egyardian99@gmail.com