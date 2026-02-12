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
echo http://${SEAWEED_HOST0}:8888 SeaweedFS Filer
```
