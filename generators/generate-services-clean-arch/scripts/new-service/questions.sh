################################################################################
echo "Service Settings"
################################################################################

SERVICE_NAME=$(./scripts/shared/read_required_text.sh "What is the name of the service?")
echo $SERVICE_NAME

echo "Create output file? (y/n)"
CREATE_OUTPUT_FILE=$(./scripts/shared/read_key.sh ${boolean_keys[@]})
echo $CREATE_OUTPUT_FILE

echo "Create validation file? (y/n)"
CREATE_VALIDATION_FILE=$(./scripts/shared/read_key.sh ${boolean_keys[@]})
echo $CREATE_VALIDATION_FILE

echo "Create map file? (y/n)"
CREATE_APP_MAP_FILE=$(./scripts/shared/read_key.sh ${boolean_keys[@]})
echo $CREATE_APP_MAP_FILE

################################################################################
sleep 1
clear
echo "Controller Settings"
################################################################################

CONTROLLER_NAME=$(./scripts/shared/read_required_text.sh "What is the name of the controller?")
echo $CONTROLLER_NAME

SERVICE_ROUTE=$(./scripts/shared/read_required_text.sh "What is the route of the service?")
echo $SERVICE_ROUTE

SELECT_MESSAGE="What type method will it be at controller?"
SELECT_DATA=("HttpGet" "HttpPost" "HttpPut" "HttpPatch" "HttpDelete")
. ./scripts/shared/select_option.sh
HTTP_METHOD=$SELECT_RESULT
echo $HTTP_METHOD

echo "Create request file? (y/n)"
CREATE_REQUEST_FILE=$(./scripts/shared/read_key.sh ${boolean_keys[@]})
echo $CREATE_REQUEST_FILE

echo "Create response file? (y/n)"
CREATE_RESPONSE_FILE=$(./scripts/shared/read_key.sh ${boolean_keys[@]})
echo $CREATE_RESPONSE_FILE

echo "Create map file? (y/n)"
CREATE_API_MAP_FILE=$(./scripts/shared/read_key.sh ${boolean_keys[@]})
echo $CREATE_API_MAP_FILE
