## Docker Compose Setup
Modify `config.env`, and run Portainer:
```sh
source config.env
docker compose -f portainer-standalone.yml up
```

To force restart a container:
```sh
docker compose -f my_compose.yml up --force-recreate my_container
```

## Disk Server
```sh
docker compose -f disk_server.yml up --remove-orphans
```

Web UI:
```sh
echo https://${SEAWEED_HOST0}:9443 Portainer
echo http://${SEAWEED_HOST0}:9333 SeaweedFS Master
echo http://${SEAWEED_HOST0}:8888 SeaweedFS Bucket Filer
```

Test S3:
```sh
aws s3 --endpoint-url http://${SEAWEED_HOST0}:8333 mb s3://test-bucket
aws s3 --endpoint-url http://${SEAWEED_HOST0}:8333 cp ~/.bashrc s3://test-bucket
aws s3 --endpoint-url http://${SEAWEED_HOST0}:8333 ls s3://test-bucket
```

Test WireGuard:
```sh
./app/wg_connect/wg_connect.sh yetiarch tk
docker exec wg_client ip addr
docker exec wg_client wg show
docker exec wg_client ping -c 1 10.8.0.2
```

## Sandbox Server

Test WireGuard:
```sh
docker exec wg_server ip addr
docker exec wg_server wg show
docker exec wg_server ping -c 1 10.8.0.1
```
