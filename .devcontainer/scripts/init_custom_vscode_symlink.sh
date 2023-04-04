#!/usr/bin/env bash

# Symlink for custom vscode folder
basepath=$ATHENA_ROOT
symlink=$basepath/.vscode

# check if .vscode folder exist as a non-symbolic folder
if [ -d $symlink ] && [ ! -L $symlink ];
then
    echo -e "ERROR: could not create the symlink because" $symlink "folder exists."
else
    ln -sfn "$basepath/src/$VSCODE_CONFIG_PATH" "$symlink"
    chown "${HOST_USER}":"${HOST_GROUP}" "$symlink"
    echo -e "Created a symlink from the custom vscode folder ${VSCODE_CONFIG_PATH} with name" $symlink
fi
