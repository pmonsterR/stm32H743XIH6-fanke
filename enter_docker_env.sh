#!/bin/bash

topdir="$(dirname $(readlink -f "$0"))"
d_workspace="$topdir/workspace"

required_cmds=(
    "which"
    "echo"
    "mkdir"
    "docker"
)

log_dump() {
    local level=$1
    local msg=$2

    [ "$level" != "None" ] && echo -e "\n$level: $msg" || echo -ne "$msg"
}

check_cmds() {
    local cmd=$1

    log_dump None "Checking $cmd ... "
    if which $cmd > /dev/null 2>&1; then
        log_dump None "OK\n"
    else
        log_dump None "FAILED\n"
        log_dump Error "Missing $cmd, please retry after installed."
        exit 1
    fi
}

log_dump Info "Check the environment in which the script is executed."
for cmd in ${required_cmds[@]}; do
    check_cmds $cmd
done

log_dump Info "Update latest docker image."
if docker pull ghcr.io/pmonsterr/docker_build_env:latest ; then
    log_dump None "Successfully\n"
else
    log_dump Error "Failed to update docker images, please check the network."
    exit 1
fi

log_dump Info "Check the latest commit of the remote repository."
log_dump None "Get latest commit ... "
latest=$(cd $topdir; git ls-remote origin | grep -w 'heads/docker_build_env$' | awk '{print $1}' 2>/dev/null)
log_dump None "$latest\n"

if [ -n "$latest" ]; then
	current=$(cd $topdir; git rev-parse HEAD 2>/dev/null)
	[ "$current" = "$latest" ] || log_dump Warning "The current commit is $current, please execute 'git pull' if needed to get the latest updates."
fi

if [ ! -d "$d_workspace" ]; then
    log_dump Info "Create a workspace and mount it under the home directory of the user named fanke."
    log_dump None "Creating $d_workspace ..."
    err=$(mkdir -p $d_workspace 2>&1)
    if [ $? -eq 0 ]; then
        log_dump None "OK\n"
    else
        log_dump None "FAILED\n"
        log_dump Error "$err"
        exit 1
    fi
fi

docker run -ti --hostname stm32H743XIH6 --rm -e SETID=$(id -u) -v "$d_workspace:/home/fanke/workspace" ghcr.io/pmonsterr/docker_build_env:latest
