

- Istio sees the clients in keycloak as users / client apps; but it can also see them as the audience.
- Auth options
    - User/pass
    - Define a single client, and users which belong to it. 
    - As soon as the users are authenticated, they have access to everything.
    - Istio authorizes based in the audience key
    - Setup
        - Did not test if possible, but…
        - New client > client protocol OpenID > access type public > redirect whatever “/”?

```
curl 'https://authenticate.dev-app.snglr.com/auth/realms/<<your realm>>/protocol/openid-connect/token' --data 'grant_type=password&username=<<user name>>&password=<<password>>&client_id=<<client id>>'
```

    - API key
    - Create a client, which is capable of defining an access key, and then everything with this key has access.
    - No differences between who has the key.
    - Need to create clients manually, and unless we use wildcards, we have to adjust Istio as well.
    - Istio authorizes based in the audience key
    - Setup
        - New client > client protocol OpenID > access type confidential > allow auth ON > redirect whatever “/”?
        - Credential tab then has a private key
        - Roles tab has UMA protection > users in role > service account > email verifier ON
        - In the mappers you can set the contents of the JWT for your desired audience

```
curl 'https://authenticate.dev-app.snglr.com/auth/realms/<<realm name>>/protocol/openid-connect/token' --data 'grant_type=client_credentials&client_secret=<<secret>>&client_id=<<client ID>>'
```
- user/pass -- with groups
    - Users authenticate with user/pass, but the JWT holds their group.
    - The Istio then checks whether the client is correct, but also if the user is in the right group.
    - Istio authorizes based in the audience key; and the custom claims
    - Setup
        - New client > client protocol OpenID > access type public > redirect whatever “/”?
        - In the roles tab within a client > create new client > the name is the name for which you will check in Istio Authorization policy
```
    rules:
    - to:
      - operation:
          paths:
          - /info*
      when:
      - key: "request.auth.claims[resource_access][<<client name>>][roles]"
          values: ["<<role name>>"]
```
        - Create new client scope > scopes > choose your client > choose which roles / “actions” you want to include in the JWT; based on this you will be able to filter users within the same clients; this defines which group will have access to which subsections within a client
        - Create new group > role mappings > choose your client > choose which roles / “actions” the group will be able to execute; which subsection of the client will be this group able to access
        - This can be possibly done easier / automated, but the solutions were ugly https://stackoverflow.com/questions/54305880/how-can-i-restrict-client-access-to-only-one-group-of-users-in-keycloak
        - Then just create a user and assign them to a group
```
curl 'https://authenticate.dev-app.snglr.com/auth/realms/<<your realm>>/protocol/openid-connect/token' --data 'grant_type=password&username=<<user name>>&password=<<password>>&client_id=<<client id>>'
```

## Export / Import
```
/opt/jboss/keycloak/bin/standalone.sh -Dkeycloak.migration.action=export -Dkeycloak.migration.provider=dir -Dkeycloak.migration.dir=deleteme -Djboss.socket.binding.port-offset=3
```

Extra args for importing at the keycloak initialization
```
-Dkeycloak.migration.action=import -Dkeycloak.migration.provider=singleFile -Dkeycloak.migration.file=/import/import.json -Dkeycloak.profile.feature.upload_scripts=enabled -Dkeycloak.migration.strategy=IGNORE_EXISTING
```