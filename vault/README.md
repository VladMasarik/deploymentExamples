# Policies
You can create policies which allow you to specify basically permissions for certain secret and other stuff.

These policies can be appended to users on creation of token. You cannot change the policies of a token but you can change the policy.
```
vault token create -period="30m" -policy="web cluster autoscaler"
```

```
path "secret/web-cluster-autoscaler" {
  capabilities = [] # Empty means, allow everything
}
```

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