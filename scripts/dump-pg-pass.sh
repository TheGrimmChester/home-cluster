kubectl get secret --namespace default postgres-app -o jsonpath="{.data.password}" | base64 --decode
