
# this file is called by VSCode as init command
# for local debugging, call this directly from /src
# do not use this script to invoke any hd-cde functionality outside VSCode, use hd-cde as simple CLI
HOST_WORKSPACE="$(dirname "$(pwd)"/../../..)"
PARENT="$(readlink -f "$HOST_WORKSPACE"/..)"
INSTANCE_IDENTIFIER="$(basename $(dirname "$PARENT"))"-"$(basename "$PARENT")"
EXIST=false
INSTANCE_NAME=$(${HOST_WORKSPACE}/src/tools/hd_docker/dev_env/cde.sh list --vscode)

#TODO ios2bp inspect container hash and warn if using an outdated container

VSCODE_PARAMS=""
if [[ $KEEP_EXTENSIONS == "true" ]]; then
    VSCODE_PARAMS="--keep-extensions"
fi

if [[ -n $INSTANCE_NAME ]]; then
    echo VSCode container instance identified: $INSTANCE_NAME
    EXIST=true
fi
if [[ $EXIST == "false" ]]; then
    # check for stopped containers
    INSTANCE_NAME=$(${HOST_WORKSPACE}/src/tools/hd_docker/dev_env/cde.sh list --vscode --stopped)
    if [[ -n $INSTANCE_NAME ]]; then
        echo Trying to re-start container, please wait...
	docker start $INSTANCE_NAME
	echo VSCode container instance identified: $INSTANCE_NAME
    else
	echo No running or stopped VSCode containers found. Creating new one...
	echo "${HOST_WORKSPACE}/src/tools/hd_docker/dev_env/cde.sh server --vscode $VSCODE_PARAMS"
        eval "${HOST_WORKSPACE}/src/tools/hd_docker/dev_env/cde.sh server --vscode $VSCODE_PARAMS"
    fi
fi
echo ----
echo Warning! Docker container will not auto-close after you closed VSCode.
echo If you want to shut down the container:
echo "Check what is open with 'hd-cde list --vscode' and stop with 'hd-cde stop --vscode' "
echo ----

