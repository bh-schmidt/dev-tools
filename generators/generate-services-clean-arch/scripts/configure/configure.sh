SOLUTION_FOLDER=.

SELECT_DATA=($(find $SOLUTION_FOLDER -type f -name "*.csproj"))
[ ${#SELECT_DATA[@]} -eq 0 ] && echo "No csproj files found" && exit 0

SELECT_MESSAGE="Select the api project."
. $BASE_DIRECTORY/scripts/shared/select_option.sh 
API_PROJECT_DIRECTORY=$SELECT_RESULT

SELECT_MESSAGE="Select the service project."
. $BASE_DIRECTORY/scripts/shared/select_option.sh 
SERVICE_PROJECT_DIRECTORY=$SELECT_RESULT

API_PROJECT=$(cat $API_PROJECT_DIRECTORY)
SERVICE_PROJECT=$(cat $API_PROJECT_DIRECTORY)

# change the namespace
API_PROJECT_NAMESPACE=$(echo "$API_PROJECT" | sed -n 's/.*<RootNamespace>\(.*\)<\/RootNamespace>.*/\1/p')
SERVICE_PROJECT_NAMESPACE=$(echo "$SERVICE_PROJECT" | sed -n 's/.*<RootNamespace>\(.*\)<\/RootNamespace>.*/\1/p')

if [ -z $API_PROJECT_NAMESPACE ]; then
    API_PROJECT_NAMESPACE=$($BASE_DIRECTORY/scripts/shared/read_required_text.sh "Namespace of api couldn't be found. Inform it here.")
fi

if [ -z $SERVICE_PROJECT_NAMESPACE ]; then
    SERVICE_PROJECT_NAMESPACE=$($BASE_DIRECTORY/scripts/shared/read_required_text.sh "Namespace of service couldn't be found. Inform it here.")
fi

API_PROJECT_FOLDER=$(echo "$API_PROJECT_DIRECTORY" | sed -e 's/[^/]*$//g')
SERVICE_PROJECT_FOLDER=$(echo "$SERVICE_PROJECT_DIRECTORY" | sed -e 's/[^/]*$//g')

CONTROLLER_FOLDER=$($BASE_DIRECTORY/scripts/shared/read_required_text.sh "Where is the controller's folder? e.g: ./Controllers/v1")
SERVICE_FOLDER=$($BASE_DIRECTORY/scripts/shared/read_required_text.sh "Where is the service's folder? e.g: ./Services")



cat <<EOF >./generator_config.txt
SCRIPT_VERSION=$SCRIPT_VERSION

API_PROJECT_DIRECTORY=$API_PROJECT_DIRECTORY
API_PROJECT_FOLDER=$API_PROJECT_FOLDER
CONTROLLER_FOLDER=$CONTROLLER_FOLDER
API_PROJECT_NAMESPACE=$API_PROJECT_NAMESPACE
SERVICE_PROJECT_DIRECTORY=$SERVICE_PROJECT_DIRECTORY
SERVICE_PROJECT_FOLDER=$SERVICE_PROJECT_FOLDER
SERVICE_FOLDER=$SERVICE_FOLDER
SERVICE_PROJECT_NAMESPACE=$SERVICE_PROJECT_NAMESPACE
EOF