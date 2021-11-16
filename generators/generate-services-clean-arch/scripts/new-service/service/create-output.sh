[ "$CREATE_OUTPUT_FILE" = "n" ] && return

REPLACE_TEXT=$(<$BASE_DIRECTORY/templates/service/output.txt)
REPLACE_TEXT="$(. $BASE_DIRECTORY/scripts/shared/replace_all.sh "ServiceName" "$SERVICE_NAME")"
REPLACE_TEXT="$(. $BASE_DIRECTORY/scripts/shared/replace_all.sh "ServiceNamespace" "$SERVICE_NAMESPACE.$SERVICE_DOMAIN")"

mkdir -p "$SERVICE_FOLDER"
cd "$SERVICE_FOLDER"

mkdir -p "$SERVICE_DOMAIN"
cd "$SERVICE_DOMAIN"

mkdir -p "./$SERVICE_NAME"
cd "./$SERVICE_NAME"

echo "$REPLACE_TEXT" > "./$SERVICE_NAME""Output.cs"

cd $SOLUTION_FOLDER