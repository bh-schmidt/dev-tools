REPLACE_TEXT=$(<$BASE_DIRECTORY/templates/api/controller.txt)
REPLACE_TEXT="$(. $BASE_DIRECTORY/scripts/shared/replace_all.sh "ServiceName" "$SERVICE_NAME")"
REPLACE_TEXT="$(. $BASE_DIRECTORY/scripts/shared/replace_all.sh "ServiceNamespace" "$SERVICE_NAMESPACE.$SERVICE_DOMAIN")"
REPLACE_TEXT="$(. $BASE_DIRECTORY/scripts/shared/replace_all.sh "ControllerNamespace" "$CONTROLLER_NAMESPACE.$SERVICE_DOMAIN")"

REPLACE_TEXT="$(. $BASE_DIRECTORY/scripts/shared/replace_all.sh "ControllerName" "$CONTROLLER_NAME")"
REPLACE_TEXT="$(. $BASE_DIRECTORY/scripts/shared/replace_all.sh "HttpMethod" "$HTTP_METHOD")"
REPLACE_TEXT="$(. $BASE_DIRECTORY/scripts/shared/replace_all.sh "ServiceRoute" "$SERVICE_ROUTE")"

mkdir -p "$CONTROLLER_FOLDER"
cd $CONTROLLER_FOLDER

mkdir -p "$SERVICE_DOMAIN"
cd "$SERVICE_DOMAIN"

mkdir -p "./$SERVICE_NAME"
cd "./$SERVICE_NAME"

echo "$REPLACE_TEXT" > "./$SERVICE_NAME""Controller.cs"

cd $SOLUTION_FOLDER