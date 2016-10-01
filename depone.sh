# This script deploys one vm on the GCC
NAME=$1

echo "
resourcs:
- name: $NAME
  type: compute.v1.instance
  properties:
    zone: us-west1-b
    machineType: https://www.googleapis.com/compute/v1/projects/pioml-141022/zones/us-west1-b/machineTypes/f1-micro
    disks:
    - deviceName: boot
      type: PERSISTENT
      boot: true
      autoDelete: true
      initializeParams:
        sourceImage: https://www.googleapis.com/compute/v1/projects/ubuntu-os-cloud/global/images/ubuntu-1604-xenial-v20160907a
    networkInterfaces:
    - network: https://www.googleapis.com/compute/v1/projects/pioml-141022/global/networks/default
      # Access Config required to give the instance a public IP address
      accessConfigs:
      - name: External NAT
        type: ONE_TO_ONE_NAT
" >> run.yaml

sudo gcloud deployment-manager deployments \
	create $NAME \
	--config run.yaml
