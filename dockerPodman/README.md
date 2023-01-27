## Docker / podman
Exec into container
```
podman exec -it b3303efbf62a bash
```
List containers
```
podman ps
```
Clean volumes / images
```
podman volume prune
```
Run container
- `--rm` removes container once stopped
- `-p` ports
- `-v` volumes
- `--name` container name
- `-e` container variable
```
podman run -p 5432:5432 --rm \
-v /home/vmadmin/postgresdb/beelivingsensor-postgis-ygug:/var/lib/postgresql/data \
--name postgis \
-e POSTGRES_PASSWORD="password" docker.io/postgis/postgis:12-3.3-alpine 
```

## Compose
- Ports are for mapping to outside, if you set network you dont need ports to connect between containers
- Dont forget that your app has to listne on 0.0.0.0; 127.0.0.1 is just localhost, which allows connections from the container, but you want connections from the IP that the container got so that you can connect to it from your PC
- Force a build if dockerfile changed from the last time you used it
```
docker compose up --build
```
