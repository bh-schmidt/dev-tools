boolean_keys=("y" "n")

SOLUTION_FOLDER=.

echo "Loading configuration"
. $BASE_DIRECTORY/scripts/new-service/load-configuration.sh

. $BASE_DIRECTORY/scripts/new-service/questions.sh

echo "Generating files..."

. $BASE_DIRECTORY/scripts/new-service/service/create-service.sh
. $BASE_DIRECTORY/scripts/new-service/service/create-input.sh
. $BASE_DIRECTORY/scripts/new-service/service/create-output.sh
. $BASE_DIRECTORY/scripts/new-service/service/create-validation.sh

. $BASE_DIRECTORY/scripts/new-service/api/create-controller.sh
. $BASE_DIRECTORY/scripts/new-service/api/create-request.sh
. $BASE_DIRECTORY/scripts/new-service/api/create-response.sh