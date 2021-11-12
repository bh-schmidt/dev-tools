REPLACE_TEXT=$(<./templates/api/controller.txt)
REPLACE_TEXT="$(. ./scripts/shared/replace_all.sh "ServiceName" "$SERVICE_NAME")"
REPLACE_TEXT="$(. ./scripts/shared/replace_all.sh "ServiceNamespace" "$SERVICE_NAMESPACE")"
REPLACE_TEXT="$(. ./scripts/shared/replace_all.sh "ControllerNamespace" "$CONTROLLER_NAMESPACE")"

REPLACE_TEXT="$(. ./scripts/shared/replace_all.sh "ControllerName" "$CONTROLLER_NAME")"
REPLACE_TEXT="$(. ./scripts/shared/replace_all.sh "HttpMethod" "$HTTP_METHOD")"
REPLACE_TEXT="$(. ./scripts/shared/replace_all.sh "ServiceRoute" "$SERVICE_ROUTE")"
echo "$REPLACE_TEXT"