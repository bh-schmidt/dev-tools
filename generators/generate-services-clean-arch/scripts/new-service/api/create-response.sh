[ "$CREATE_RESPONSE_FILE" = "n" ] && return

REPLACE_TEXT=$(<$BASE_DIRECTORY/templates/api/response.txt)
REPLACE_TEXT="$(. $BASE_DIRECTORY/scripts/shared/replace_all.sh "ServiceName" "$SERVICE_NAME")"
REPLACE_TEXT="$(. $BASE_DIRECTORY/scripts/shared/replace_all.sh "ControllerNamespace" "$CONTROLLER_NAMESPACE.$SERVICE_DOMAIN")"

mkdir -p "$CONTROLLER_FOLDER"
cd $CONTROLLER_FOLDER

mkdir -p "$SERVICE_DOMAIN"
cd "$SERVICE_DOMAIN"

mkdir -p "./$SERVICE_NAME"
cd "./$SERVICE_NAME"

echo "$REPLACE_TEXT" > "./$SERVICE_NAME""Response.cs"

cd $SOLUTION_FOLDER