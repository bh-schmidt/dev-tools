REPLACE_TEXT=$(<./templates/service/input.txt)
REPLACE_TEXT="$(. ./scripts/shared/replace_all.sh "ServiceName" "$SERVICE_NAME")"
REPLACE_TEXT="$(. ./scripts/shared/replace_all.sh "ServiceNamespace" "$SERVICE_NAMESPACE")"
echo "$REPLACE_TEXT"