## AWS CLI

Configure the AWS account for the first time
```
aws configure --profile prod
```

Update the k8s config based on a profile, or provide it which role it should use
```
aws eks update-kubeconfig --name snglr-tf-k8-prod --profile sec
aws eks update-kubeconfig --name snglr-tf-k8-prod --role-arn arn:aws:iam::04AccountID35:role/EKSDeploymentRole --profile sec
```
