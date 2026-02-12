# Disk Server
Modify `config.env`, and run Portainer:
```sh
source config.env
docker compose -f portainer-standalone.yml up
```

```sh
docker compose -f disk_server.yml up
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
