#!/usr/bin/env bash
# @copyright (c) 2023 by Robert Bosch GmbH. All rights reserved.
#
# The reproduction, distribution and utilization of this file as
# well as the communication of its contents to others without express
# authorization is prohibited. Offenders will be held liable for the
# payment of damages and can be prosecuted. All rights reserved
# particularly in the event of the grant of a patent, utility model
# or design.
# This script is the last of three that finalizes container setup when a dev container is created

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

cd $SCRIPT_DIR

if [ -f .env ]
then
  echo "Sourcing .env file found at $SCRIPT_DIR/.env."
  export $(cat .env | xargs)
fi

if [[ -n "${VSCODE_CONFIG_PATH}" ]]; then
  echo "adding sybmolic link to ${VSCODE_CONFIG_PATH} from .vscode ..."
  ./scripts/init_custom_vscode_symlink.sh
fi

# setup.sh works only in src folder
echo "Installing pre-commit githooks"
cd .. && .githooks/setup.sh && cd $SCRIPT_DIR
