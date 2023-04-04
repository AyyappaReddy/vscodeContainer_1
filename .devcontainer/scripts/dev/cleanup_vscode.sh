#!/usr/bin/env bash

# WARNING: this script is for the developers of .devcontainer, and may delete something you may need
# It can be executed on the host machine, to clear whatever relates to vscode for a clean slate


SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
SRC_DIR=$SCRIPT_DIR/../../..

echo ""
echo "Stoping the running containers"
$SRC_DIR/tools/hd_docker/dev_env/cde.sh stop

echo "Killing all vscode nodes"
killall node

echo "Deleting traces of vscode on the host"
del_dirs=(~/.vscode* /tmp/vscode* /tmp/devcontainercli* /tmp/docker-vscode*)

for del_dir in "${del_dirs[@]}"
do
    echo "Removing $del_dir"
    rm -rf "$del_dir"
done

# Sometimes permission issue happens on /tmp/docker-vscode-$USER folder, these command prevent it to happen
mkdir -p /tmp/docker-vscode-$USER
sudo chown -R $USER /tmp/docker-vscode-$USER

echo ""
echo "Delete vscode docker volume"
docker volume rm vscode

echo "Deleting temporary docker images"
del_imgs=(vsc-src dev_container)
for del_img in "${del_imgs[@]}"
do
    rm_images=$(docker images | grep $del_img )
    if [[ -n ${rm_images} ]]; then
      echo "docker images to remove:" ${rm_images}
      docker rmi -f ${rm_images}
    fi
done


# This removes all the pulled images from the project, NOT recommended as pulling the image will be required.
# docker rmi -f $(docker images | grep 'vscodeContainer_1mirrored.azurecr.io')

echo "Pruning Docker system"
docker system prune
