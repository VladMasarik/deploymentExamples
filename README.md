# Debugging
List all resources in any namespace. Basically goes over every API definition and lists the resources
```
NS="your namespace"
kubectl api-resources --verbs=list --namespaced -o name   | xargs -n 1 kubectl get --show-kind --ignore-not-found -n $NS
```



# Grafana
- I suggest copying stuff from other dashboards.
- Dont forget to copy also the variables from each dashboard
- Check multiple time ranges if stuff is showing
- Also, the Panel "resolution" might be too high/low; not sure what it is, but seems like we are collecting data only rarely, and then it wont show properly
- In  the legend, you can use "{{cpu}}" to denote which of the labels should be used
- Set for graphs
Tooltip > All
Panel > Name
Standard options > Unit
Legend
Resolution
- Set for table
Graph type > table
Data format > Table
Instant > True
Transform > Outer join
Transform > Organize fields
Override > bits (SI)