# Initialize
Whenever you create a new Vault instance you have to fist initialize the Vault. It will output initialization keys that you have to save in a safe place because if you lose them, you lose all of the access to Vault once it is restarted. It also give you a root token, which acts as a root user login.
```
vault operator init
```

# Policies
You can create policies which allow you to specify basically permissions for certain secret and other stuff.

These policies can be appended to users on creation of token. You cannot change the policies of a token but you can change the policy.
```
vault token create -period="30m" -policy="web cluster autoscaler"
```

Just don't forget the `/data/` part in the secret name!
```
path "secret/data/web-cluster/cluster-autoscaler" {
  capabilities = [] # Empty means, allow everything
}
```

# AWS storage
Don't forget to add the delete permissions to the bucket, otherwise you will not be able to delete the data from the Vault

# Tokens
Each token outside of tokens created with `-period` flag have a maximum TTL. Meaning they will eventually stop being valid, and you cannot renew them.

Periodic tokens will work forever if you keep renewing them.
```
vault token create -period="30m"
vault token renew s.A0r2aKOMbJ6swM9yZj
```

# Seal / Unseal
Intial creating of vault leaves it in locked state. You need to initialize it, which creates the unseal keys or if you have automated unseal, recovery keys.

Each time a Vault is restarted it will stay sealed, and has to be either configured for automatic unseal, or manually unsealed before it can be used.
```
vault operator unseal 64c8ef42ad9b58d202e4a49
```

# Secrets
You can enable a storage engine, and also define path to this storage with:
```
vault secrets enable -path=mysecretpath/ kv-v2 # kv-v2 is the engine
```

You can add in secrets and read them. You have to define path to the secret, and then also which key value pairs it holds.
```
vault kv put mysecretpath/mysecret mykey="myvalue"
vault kv get mysecretpath/mysecret
```

# Users auth / Login
```
vault auth enable userpass
vault write auth/userpass/users/myuser password=12345 policies="mypolicy1,mypolicy2"
vault login -method=userpass username=myuser password=12345
```

vault write auth/userpass/users/bitbucket-pipeline password=qqqq policies="web-cluster-read,conductor-cluster-read"

vault login -method=userpass username=bitbucket-pipeline password=qqqq

path "secret/web-cluster/*" {
  capabilities = ["read"]
}

path "secret/conductor-cluster/*" {
  capabilities = ["read"]
}

## Root token login
```
vault login s.BUiP
```

# Pipeline Vault request
```
export PASSWORD="$(vault kv get -field=password secret/myproject/production/db)"
```