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

To clearly see service status:
```sh
docker compose -f my_compose.yml ps --format "table {{.Name}}\t{{.Status}}\t{{.Health}}"
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
./app/wg_customized/connect.sh yetiarch tk
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

# test proxy
docker exec wg_server curl 10.8.0.1:8333
docker run \
    --network container:wg_server \
    -e AWS_ACCESS_KEY_ID=any -e AWS_SECRET_ACCESS_KEY=any \
    -it amazon/aws-cli s3 --endpoint-url http://10.8.0.1:8333 \
    ls s3://test-bucket
```

## Core Server
Test:
```sh
curl -X POST http://yetiarch:8001/hello -H "Content-Type: application/json" -d '{"name": "Leo", "age": "18"}'
```
