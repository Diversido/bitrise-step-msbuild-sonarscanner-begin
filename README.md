# MSBuild SonarScanner (Begin)

This is a Begin step of MSBuild SonarScanner CLI.  
The scanner for dotnet consists of the two steps:
- `sonar-scanner begin`
- `sonar-scanner end` 

In between of `begin` and `end` steps the build, test run and code coverage should happen.

Check official documentation [SonarScanner for MSBuild](https://docs.sonarqube.org/latest/analysis/scan/sonarscanner-for-msbuild/) to understand how the scan process happens for dotnet.

This step can be used for self-hosted SonarQube and SonarCloud.

## How to use this Step

This step makes sense only for Xamarin projects.

You can specify the next variables to use the step out of the box against SonarCloud:

- **SONAR_LOGIN** (secret): a username or access token (must be added to `.bitrise.secrets.yml`)
- **SONAR_PROJECT_KEY**: a project key

### User required properties

- **sonar_login**: a username or access token to authenticate with to Sonar
- **sonar_project_key**: a key of the analyzed project

### Required properties, but with predefined values

- **scanner_version**: a version used to download CLI
- **sonar_host_url**: a host url, default value is `https://sonarcloud.io`

### Optional properties:

- **sonar_organization**: an organization key
- **sonar_project_version**: a version of the project
- **sonar_project_name**: a name of the analyzed project. This overrides the project name in SonarQube

## Exported Environment variables

- **SONAR_SCANNER_FILE_PATH**: The path to `SonarScanner.MSBuild.exe` to be used in the MSBuild SonarScanner End step

# TODO

1. Wrap optional properties in group
2. Support `sonar.exclusions`
3. Add test-results if available from previous steps: `BITRISE_XAMARIN_TEST_RESULT` and `BITRISE_XAMARIN_TEST_FULL_RESULTS_TEXT`
4. Cache downloaded sonar-scanner files
