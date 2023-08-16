# Find volume-id
velero restic repo get
velero restic repo get media-default-jshxj -o yaml

# In case it is set
unset RESTIC_PASSWORD_COMMAND

# make sure you got mc and jq installed. mc is here with a profile called velero
export AWS_ACCESS_KEY_ID=$(mc alias ls velero --json | jq '.accessKey' -r)
export AWS_SECRET_ACCESS_KEY=$(mc alias ls velero --json | jq '.secretKey' -r)

# This is from https://github.com/vmware-tanzu/velero/blob/v1.7.1/pkg/restic/repository_keys.go#L35
export RESTIC_PASSWORD=static-passw0rd

export RESTIC_REPOSITORY='s3:http://10.1.2.3:9000/velero-backup/restic/media'

mkdir temp_resticmount
restic mount temp_resticmount

# open another terminal and look inside
