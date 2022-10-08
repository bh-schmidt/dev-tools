MAPPING=""
IMPORTS=""

if [ "$CREATE_REQUEST_FILE" = "y" ]; then
    MAPPING="$MAPPING""
        CreateMap<""$SERVICE_NAME""Request, ""$SERVICE_NAME""Input>();"
fi

if [ "$CREATE_RESPONSE_FILE" = "y" && "$CREATE_OUTPUT_FILE" = "y" ]; then
    MAPPING="$MAPPING""
        CreateMap<""$SERVICE_NAME""Output, ""$SERVICE_NAME""Response>();"
fi

if [ "$MAPPING" != "" ]; then
    IMPORTS="
using $SERVICE_NAMESPACE.$SERVICE_DOMAIN.$SERVICE_NAME;"
fi

REPLACE_TEXT=$(<$BASE_DIRECTORY/templates/api/map.txt)
REPLACE_TEXT="$(. $BASE_DIRECTORY/scripts/shared/replace_all.sh "ServiceName" "$SERVICE_NAME")"
REPLACE_TEXT="$(. $BASE_DIRECTORY/scripts/shared/replace_all.sh "ControllerNamespace" "$CONTROLLER_NAMESPACE.$SERVICE_DOMAIN")"
REPLACE_TEXT="$(. $BASE_DIRECTORY/scripts/shared/replace_all.sh "Mapping" "$MAPPING")"
REPLACE_TEXT="$(. $BASE_DIRECTORY/scripts/shared/replace_all.sh "Imports" "$IMPORTS")"

mkdir -p "$CONTROLLER_FOLDER"
cd $CONTROLLER_FOLDER

mkdir -p "$SERVICE_DOMAIN"
cd "$SERVICE_DOMAIN"

mkdir -p "./$SERVICE_NAME"
cd "./$SERVICE_NAME"

echo "$REPLACE_TEXT" >"./$SERVICE_NAME""MapProfile.cs"

cd $SOLUTION_FOLDER
