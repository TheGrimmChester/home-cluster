# Mark the node as unschedulable.
echo Mark the node as unschedulable $NODENAME
kubectl cordon $NODENAME

# Get the list of namespaces running on the node.
NAMESPACES=$(kubectl get pods --all-namespaces -o custom-columns=:metadata.namespace --field-selector spec.nodeName=$NODENAME | sort -u | sed -e "/^ *$/d")

# forcing a rollout on each of its deployments.
# Since the node is unschedulable, Kubernetes allocates
# the pods in other nodes automatically.
for NAMESPACE in $NAMESPACES
do
    echo deployment restart for $NAMESPACE
    kubectl rollout restart deployment/name -n $NAMESPACE
done

# Wait for deployments rollouts to finish.
for NAMESPACE in $NAMESPACES
do
    echo deployment status for $NAMESPACE
    kubectl rollout status deployment/name -n $NAMESPACE
done

# Drain node to be removed
kubectl drain $NODENAME --ignore-daemonsets --delete-emptydir-data
