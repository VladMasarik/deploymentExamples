
# Keycloak
## Login
```
TOKEN=$(curl -vvv 'https://authenticate.dev-app.snglr.com/auth/realms/snglr-model-checker/protocol/openid-connect/token' --data 'grant_type=password&username=x@x.com&password=x&client_id=snglr-model-checker-web' | jq -r .access_token)
echo $TOKEN
curl -L -vvv 'qqq.dev-app.snglr.com/infoqq' -H  "Authorization: Bearer $TOKEN"

# or you can use this login type
# I believe you can generate the key in keycloak
curl 'https://authenticate.dev-app.snglr.com/auth/realms/snglr-model-checker/protocol/openid-connect/token' --data 'grant_type=client_credentials&client_secret=be2c0ae0-xxxx-xxxx-xxxx-261102b9fa43&client_id=deleteme-api'
```

# Kafka
## List input
```
kubectl run -ti --image=gcr.io/google_containers/kubernetes-kafka:1.0-10.2.1 consume --restart=Never --rm -- kafka-console-consumer.sh --topic model-checker-logs --bootstrap-server b-1.snglr-tf-kafka-dev.n97pvj.c2.kafka.eu-central-1.amazonaws.com:9092\,b-2.snglr-tf-kafka-dev.n97pvj.c2.kafka.eu-central-1.amazonaws.com:9092\,b-3.snglr-tf-kafka-dev.n97pvj.c2.kafka.eu-central-1.amazonaws.com:9092
```

# Fill up memory
Use up 500MB of memory for the next 30 seconds.
```
cat <( </dev/zero head -c 500m) <(sleep 30) | tail
```
