
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
`--rm` removes container once stopped
`-p` ports
`-v` volumes
`--name` container name
`-e` container variable
```
podman run -p 5432:5432 --rm \
-v /home/vmadmin/postgresdb/beelivingsensor-postgis-ygug:/var/lib/postgresql/data \
--name postgis \
-e POSTGRES_PASSWORD="password" docker.io/postgis/postgis:12-3.3-alpine 
```
