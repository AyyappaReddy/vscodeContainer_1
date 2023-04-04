#!/bin/bash
# @copyright (c) 2022 by Robert Bosch GmbH. All rights reserved.
#
# The reproduction, distribution and utilization of this file as
# well as the communication of its contents to others without express
# authorization is prohibited. Offenders will be held liable for the
# payment of damages and can be prosecuted. All rights reserved
# particularly in the event of the grant of a patent, utility model
# or design.
# This script runs on the HOST machine before the container is created.

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

cd $SCRIPT_DIR

if [ -f .env ]
then
  echo "Sourcing .env file found at $SCRIPT_DIR/.env."
  export $(cat .env | xargs)
fi


# revive or spin up hd-cde container in vscode mode
./scripts/create_hd_cde_if_needed.sh
