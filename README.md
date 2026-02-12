# Disk Server
```sh
docker compose -f portainer-standalone.yml up
```

Upload `disk_server.yml`. To test:
```sh
docker compose -f disk_server.yml --env-file config.env up
```
