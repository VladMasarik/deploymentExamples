# Queries
```
genre(func: gt(count(~genre), 30000)){
name@en
~genre (first:1) {
    name@en
}
}


query all($uploadId: int, $globalId: string) {
            IFC4_IfcSpace_Entity(func: eq(IFC4_IfcRoot_Entity.globalId, "1IV1WMGn98aPwoEeo8rxkv")) {
                expand(_all_)
                }
            }



query all($uploadId: int, $globalId: string) {
            IFC4_IfcSpace_Entity(func: eq(release_date,"1977-05-25T00:00:00Z")) {
                expand(_all_)
                }
            }

has(director.film), first: 5


query all($uploadId: int, $globalId: string) {
            IFC4_IfcSpace_Entity(func: has(IFC4_IfcRoot_Entity.globalId), first: 5) {
                expand(_all_)
                }
            }




query all($uploadId: int, $globalId: string) {
            IFC4_IfcSpace_Entity(func: has(IFC4_IfcWorkTime_Entity.dataOrigin), first:5) {
                expand(_all_)
                }
            }




query all($uploadId: int, $globalId: string) {
            IFC4_IfcSpace_Entity(func: eq(release_date,"1977-05-25T00:00:00Z")) {
                expand(_all_)
                }
            }
```

# Backup
```

# Set these env vars
export AWS_ACCESS_KEY="" # Account which has access to the S3 bucket
export AWS_SECRET_KEY=""
export AWS_REGION="eu-central-1"
export AWS_BUCKET_NAME="snglr-tf-dgraph-backups-dev"
export AWS_BACKUP_FOLDER_NAME="dgraph.r250002.u1031.1601" # Name of the backup which you want to import. It is basically a folder name in the S3, eg. "dgraph.r250002.u1031.1537"
export ZERO_HOST="dgraph-dgraph-zero-headless.dgraph.svc.cluster.local:5080" # Get from either service name, or you can execute `ps -aux`, and you can see the dgraph process and the services it is connected to, so choose one, eg. "dgraph-dgraph-zero-headless.dgraph.svc.cluster.local:5080"

# Initiate backup import
dgraph live \
--files s3://s3.$AWS_REGION.amazonaws.com/$AWS_BUCKET_NAME/$AWS_BACKUP_FOLDER_NAME \
--schema s3://s3.$AWS_REGION.amazonaws.com/$AWS_BUCKET_NAME/$AWS_BACKUP_FOLDER_NAME/g01.schema.gz \
--zero $ZERO_HOST
```