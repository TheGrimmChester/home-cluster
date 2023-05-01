velero install     --provider aws     --plugins velero/velero-plugin-for-aws:v1.2.1     --bucket velero     --secret-file ./credentials-velero --use-volume-snapshots=true --use-node-agent    --snapshot-location-config region=minio      --backup-location-config region=minio,s3ForcePathStyle="true",s3Url=https://nas.:9009


kubectl delete namespace/velero clusterrolebinding/velero
kubectl delete crds -l component=velero

