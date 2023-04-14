#!/usr/bin/env bash
# Copyright 2023 SAP SE or an SAP affiliate company
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" &>/dev/null && pwd)"
PROJECT_DIR="$(dirname "$SCRIPT_DIR")"

source "$(dirname "${0}")"/pki_gen.sh

# create the testdata directory to all PKI resources that are created. All unit tests will refer
# to PKI resources kept under this path.
TEST_PKI_DIR="${PROJECT_DIR}/internal/testdata"
echo "TEST_PKI_DIR = $TEST_PKI_DIR"
mkdir -p "${TEST_PKI_DIR}"

echo "> Test..."

echo "> Generating PKI material for tests..."
generatePKI "${TEST_PKI_DIR}"

echo "> Running tests..."
go test -v ./... -coverprofile cover.out

echo "> Removing PKI material..."
cleanupPKI "${TEST_PKI_DIR}"