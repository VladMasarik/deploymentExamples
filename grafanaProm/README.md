# Grafana
- grafana has its own alerts, but it also has an aplha feature since v8 for prometheus alerts
- you can enable this with `ngalerts` setting
- when defining the data sources; dont forget to set `http://` infront of them because otherwise you might get `protocol unsupported` error when creating / testing alarms
- When setting Loki, make sure the URL ends with `:3100` port definition otherwise it will try port `80`

## Alarms
You can integrate stuff with slack. 
- create a slack channel
- search for "apps" in the slack
- top right "app directory"; basically just go to website where you can create new hooks
- top right build > create new app > from scratch > select channel > Incoming webhooks > activate > add webhook
- copy the hook URL > Grafana UI > alerting > notification channels > select slack > and just paste the hook URL into the hooks
- everythng should start working
- you can add new alarm > select your notification system > be sure to test whether the alarms work as intended
https://hooks.slack.com/services/TNSDLC9C2/B02G3TTEY/n7572Kaek3oCP80Jsdaar5

## Datasources
Make sure Prometheus source has the correct Promehteus port, and `http://` prefix set as well; Otherwise the connection will fail or the alarms with be incorrect.