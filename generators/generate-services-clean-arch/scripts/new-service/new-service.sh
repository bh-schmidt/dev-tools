boolean_keys=("y" "n")

SOLUTION_FOLDER=${PARAMETERS[-1]}
[ ! -d "$SOLUTION_FOLDER" ] && echo "Directory $SOLUTION_FOLDER does not exists" && exit 0

echo "Loading configuration"
. ./scripts/new-service/load-configuration.sh

. ./scripts/new-service/questions.sh

echo "Generating files..."
SERVICE_NAMESPACE="XPInc.ForwardMarket.Settlement.Service.Application.UseCases"
CONTROLLER_NAMESPACE="XPInc.ForwardMarket.Settlement.Service.WebApi.Controllers.v1"

. ./scripts/new-service/service/create-service.sh
. ./scripts/new-service/service/create-input.sh
. ./scripts/new-service/service/create-output.sh
. ./scripts/new-service/service/create-validation.sh

. ./scripts/new-service/api/create-controller.sh
. ./scripts/new-service/api/create-request.sh
. ./scripts/new-service/api/create-response.sh