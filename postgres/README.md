
## Database
### Structure
Postgres can have multiple databases, and each has a table.
You connect to each DB individially.

### Exporting Backing up the database
You might want to setup proper password with the `.pgpass` because it will keep asking for it for every DB
```
pg_dumpall -U postgres -f myfile


pg_dumpall -U postgres -h postgres -f importme/export2
```

### Import
Ideally you want to use a superuser account
```
psql -h postgres -U postgres -d postgres -f /importme/myexport
```

### PGPASS
Password file for postgres. You can avoid putting in the password
By default it is `$HOME/.pgpass`
You can try `PGPASSFILE=/importme/.pgpass` env var
Format is `hostname:port:database:username:password`, but the first 4 things can be *
Example with password is "password"
```
*:*:*:*:password
```
It has to has `600` permissions set
```
sudo chmod 600 .pgpass 
```

### Connecting with PSQL
`-h` is host where we should connect, usually wrong, so you need to set it properly
`-U` username, by default `postgres` user which is a superuser
`-d` main DB name, might be set to something else which then results into refused connections. Default `postgres`
```
podman exec -it b3303efbf62a bash
apt update && apt -y install postgresql
psql -h postgres -U postgres -d postgres
```

### Commands
Database size
```
SELECT
    pg_database.datname,
    pg_size_pretty(pg_database_size(pg_database.datname)) AS size
    FROM pg_database;
```
`\du` Users
`\l` databases
`\dt` tables in the DB
`\?` help
`\conninfo` connection information
`\dx` installed extentions

### Env variables
`PGPASSWORD` when you are running postgres localy
`POSTGRES_PASSWORD` when running postgres as a container

### Extentions
Any extention can be installed by downloading the binary locally, and then just doing the `CREATE EXTENTION` or whatever
Remove with
```
psql
DROP EXTENSION pgaudit;
```

### Errors
`role not found` linux doesnt have such a user
`DB not found` by default `psql` tries to push you into some DB, but fails if the DB and USER name are different
