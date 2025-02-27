#!/bin/bash

# Copyright (C) 2019-2020 Zilliz. All rights reserved.
#
# Licensed under the Apache License, Version 2.0 (the "License"); you may not use this file except in compliance
# with the License. You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software distributed under the License
# is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express
# or implied. See the License for the specific language governing permissions and limitations under the License.

set -e
set -x

ARTIFACTS="${ARTIFACTS:-$(mktemp -d)}"

KIND_NAME="${1:-kind}"

mkdir -p "${ARTIFACTS}/${KIND_NAME}"

for node in `kind get nodes --name=kind | tr -s '\n' ' '`
do
  docker cp $node:/var/log "${ARTIFACTS}/${KIND_NAME}"
done

echo "Exported logs for cluster \"${KIND_NAME}\" to: \"${ARTIFACTS}/${KIND_NAME}\""
