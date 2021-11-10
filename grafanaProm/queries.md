




CPU usage of pods per some service which defined in the workflow variable.
```
rate(container_cpu_usage_seconds_total{container=""}[5m]) * on (pod) group_left(name) kube_pod_info{created_by_name="$workflow"}
```



Take metrics from Q1, and return metrics from Q1 only which have all the labels same as the Q2 metric.
Use the `on` to define the match that should happen, eg. show labels of all pods, which have the same value as the Q2 metric, in the `pod` label
```
kube_pod_labels and on(pod) kube_pod_info{pod="eventbus-default-stan-0"}
```




`* ... group_left` is pretty much the same as using `and`, but this allows you to join from the Q2 the label values mentioned in the `group_left`.
This returns CPU usage for pods that have any `upload id` and add that label to the CPU usage
```
rate(container_cpu_usage_seconds_total[5m]) * on(pod) group_left(label_upload_id) kube_pod_labels{label_upload_id!=""}
```


Q1 shows only pods that are actually having any usage
Q2 shows all of the pods even like history, which really pollutes the legend
I believe the difference is that the `$workflow` text is loaded only for the current stuff which causes only the most recent workflows to show, and not all of them
```
kube_pod_container_status_running{pod=~"$workflow.*",container="main"}
kube_pod_container_status_running{pod=~"model-checker.*",container="main"}
```











rate(container_cpu_usage_seconds_total{pod=~"model-checker.*"}[1m]) * on(pod) group_left(label_workflows_argoproj_io_workflow) kube_pod_labels{label_workflows_argoproj_io_workflow!=""}


