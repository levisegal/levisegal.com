DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
PARENT_DIR=$( dirname "${DIR}" )
ENV=""
ACCEPTED_ENVIRONMENTS[0]='staging'
ACCEPTED_ENVIRONMENTS[1]='production'

function containsElement () {
  local e
  for e in "${@:2}"; do [[ "$e" == "$1" ]] && return 0; done
  return 1
}

function getTerraformEnv {
    cd $PARENT_DIR @2> /dev/null
    pushd infrastructure/app @2> /dev/null
        local _ENV=$(terraform env list | grep '*' | awk '{ print $2 }')
    popd @2> /dev/null
    # echo "${_ENV}"
    containsElement "${_ENV}" "${ACCEPTED_ENVIRONMENTS[@]}"
    # @see http://stackoverflow.com/questions/7101995/what-does-if-eq-0-mean-for-shell-scripts
    if [ $? -eq 1 ]; then
        echo "${_ENV} is not an accepted environment";
        exit 1;
    fi
    ENV="${_ENV}"
    return 0
}

getTerraformEnv
echo "Deploying to ${ENV}..."
aws s3 sync "${PARENT_DIR}/site/public/" "s3://levisegal-site-${ENV}" "--region=us-west-2"