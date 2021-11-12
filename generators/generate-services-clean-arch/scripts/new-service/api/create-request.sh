[ "$CREATE_REQUEST_FILE" = "n" ] && return

REPLACE_TEXT=$(<./templates/api/request.txt)
REPLACE_TEXT="$(. ./scripts/shared/replace_all.sh "ServiceName" "$SERVICE_NAME")"
REPLACE_TEXT="$(. ./scripts/shared/replace_all.sh "ControllerNamespace" "$CONTROLLER_NAMESPACE")"
echo "$REPLACE_TEXT"