#!/bin/bash

set -e

NAMESPACE="default"
NAME="debug-temp"
IMAGE="arsaphone/debug:latest"
STAY=0
NODE=""
CMD="/bin/sh"

while [[ $# -gt 0 ]]; do
  case "$1" in
    -n|--namespace) NAMESPACE="$2"; shift ;;
    --name) NAME="$2"; shift ;;
    --image) IMAGE="$2"; shift ;;
    --node) NODE="$2"; shift ;;
    --stay) STAY=1 ;;
    --bash) CMD="/bin/bash" ;;
    -h|--help)
      cat <<EOF
kubectl-debugpod

Options:
  -n, --namespace <ns>     Namespace to deploy into (default: default)
  --name <name>            Pod name (default: debug-temp)
  --node <nodeName>        Schedule pod on specific node
  --stay                   Keep pod alive after exit
  --bash                   Use bash instead of sh
  -h, --help               Show this help
EOF
      exit 0
      ;;
    *) exit 1 ;;
  esac
  shift
done

kubectl apply -f - <<EOF
apiVersion: v1
kind: Pod
metadata:
  name: $NAME
  namespace: $NAMESPACE
  labels:
    app: debugpod
spec:
  containers:
  - name: debug
    image: $IMAGE
    command: ["$CMD"]
    stdin: true
    tty: true
  restartPolicy: Never
  $( [[ -n "$NODE" ]] && echo "nodeName: \"$NODE\"" )
EOF

kubectl wait --for=condition=Ready pod "$NAME" -n "$NAMESPACE" --timeout=30s || true
kubectl -n "$NAMESPACE" attach -it "$NAME"

if [[ "$STAY" -eq 0 ]]; then
  kubectl delete pod "$NAME" -n "$NAMESPACE"
fi
