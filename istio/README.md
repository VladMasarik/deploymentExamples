# Debugging
Open interactive options of the istiod, eg. set Istio logging level
```
istioctl dashboard controlz deployment/istiod.istio-system
```

Set Envoy logging level
```
istioctl pc log --level "jwt:info,http:info,rbac:info" -n istio-system istio-ingressgateway-5d6878f698-vhstf
```

Extra
```
istioctl pc
istioctl ps
istioctl analyze
istioctl x authz check istio-ingressgateway-5d6878f698-vhstf -n istio-system
```

# Architecture
## Virtual service
Acts as a redirect to a service after hitting istio

## Envoy filter
Helps you disable / enable the filters done within istio / per every envoy sidecar that you have deployed

## Request auth
Defines who should your apps authenticate with, eg. where to send the authentication requests

## Auth policy
How the authentication is supposed to work, eg. the rules of how to execute the authentication