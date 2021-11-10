
# Most of the variables are taken from the argo pipeline UI. There you can parse one of the input variables to get the proper variables from a successful pipeline

curl -X POST http://conductor.dev-app.snglr.com/trigger-model-check --data '{
"uploadPath": "upload_2021-10-04T15-22-34.3300969Z_2897abc0-cb80-400b-a81e-2b0ea5bd00b2",
"projectPath": "project_000000000010128",
"uploadId": 1645,
"workflowVersion": "model-check-wf"
}'

