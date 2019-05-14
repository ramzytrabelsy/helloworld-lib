#!/usr/bin/env bash
set -xeo pipefail

PACKAGE_NAME=$(node -e 'console.log(require("./package.json").name)')
PACKAGE_VERSION=$(node -e 'console.log(require("./package.json").version)')

rm ./*.tgz || true

npm pack

cp "${PACKAGE_NAME}-${PACKAGE_VERSION}.tgz" "${PACKAGE_NAME}.tgz"

TARGETS=(
  'helloworld-express'
  'helloworld-vue'
  'helloworld-react-material'
  'helloworld-react-antd'
  'helloworld-react-native'
)

for project in "${TARGETS[@]}"; do
    mkdir -p "../${project}/lib"
    cp "./${PACKAGE_NAME}.tgz" "../${project}/lib/${PACKAGE_NAME}.tgz"
    (
      cd "../${project}"
      if [ -f yarn.lock ]; then
        yarn add "file:lib/${PACKAGE_NAME}.tgz"
      else
        npm install "file:lib/${PACKAGE_NAME}.tgz"
      fi
    )
done
