#!/bin/bash
set -e

if [[ "${is_debug}" == "true" ]]; then
  set -x
fi

pushd $(mktemp -d)
  # download scanner
  wget https://github.com/SonarSource/sonar-scanner-msbuild/releases/download/${scanner_version}/sonar-scanner-msbuild-${scanner_version}-net46.zip
  unzip sonar-scanner-msbuild-${scanner_version}-net46.zip

  chmod +x sonar-scanner-*/bin/sonar-scanner
  TEMP_DIR=$(pwd)
popd

CMD="mono ${TEMP_DIR}/SonarScanner.MSBuild.exe begin /k:${sonar_project_key} /d:sonar.login=${sonar_login} /d:sonar.host.url=${sonar_host_url}"

if [[ ! -z ${sonar_project_name} ]]; then
  CMD="${CMD} /n:${sonar_project_name}"
fi

if [[ ! -z ${sonar_project_version} ]]; then
  CMD="${CMD} /v:${sonar_project_version}"
fi

if [[ ! -z ${sonar_organization} ]]; then
  CMD="${CMD} /o:${sonar_organization}"
fi

if [[ ! -z ${sonar_properties} ]]; then
  PROPERTIES=(${sonar_properties})
  for property in "${PROPERTIES[@]}"; do
    CMD="${CMD} /d:${property}"
  done
fi

eval $CMD

envman add --key "SONAR_SCANNER_FILE_PATH" --value "${TEMP_DIR}/SonarScanner.MSBuild.exe"
