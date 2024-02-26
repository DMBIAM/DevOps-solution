# Continuous Integration Pipeline Overview

This document provides an overview of the Continuous Integration (CI) pipeline named "CI" used in the development workflow of the project. Use action file `develops-solution-ci.yml`

## Pipeline Description

The CI pipeline is triggered on every push to the "develop" branch of the repository. It runs a series of jobs on the Ubuntu 20.04 environment to automate various stages of the software development lifecycle.

## Pipeline Structure

### Permissions

The pipeline requires specific permissions to perform certain actions within the repository. These permissions include:

- Contents: Write access to repository contents.
- Pull Requests: Write access to create and update pull requests.
- Issues: Write access to create issues.
- ID-Token: Write access for token management.

### Jobs

The CI pipeline consists of a single job named "build" which is responsible for executing the following steps:

1. **Checkout code**: Fetches the latest code from the repository using the `actions/checkout@v3` action.
2. **Build and not push Docker image**: Builds a Docker image without pushing it to the registry. It includes build arguments such as user, repository, and port.
![Build and not push Docker image](https://github.com/DMBIAM/DevOps-solution/blob/develop/pic-evidence/run-build-image-no-push.png)
3. **Run Unit Tests**: Executes unit tests using the Python `manage.py test` command in a Docker container.
![Run Unit Tests](https://github.com/DMBIAM/DevOps-solution/blob/develop/pic-evidence/run-unit-test.png)
4. **Static Code Analysis**: Performs static code analysis using pylint in a Docker container.
![Static Code Analysis](https://github.com/DMBIAM/DevOps-solution/blob/develop/pic-evidence/run-static-code-analysis.png)
5. **Code Coverage**: Runs code coverage analysis using pytest and generates a coverage report.
![Code Coverage](https://github.com/DMBIAM/DevOps-solution/blob/develop/pic-evidence/run-code-coverage.png)
6. **Run Bandit for security analysis**: Conducts security analysis using Bandit in a Docker container.
![Run Bandit for security analysis](https://github.com/DMBIAM/DevOps-solution/blob/develop/pic-evidence/run-security-analysis.png)
7. **Generate Failure Comment**: Generates a failure comment if any of the previous steps fail. It creates an issue comment with details about the failed step, workflow, actor, run ID, SHA, and a link to the pipeline run for further verification.
![Generate Failure Comment](https://github.com/DMBIAM/DevOps-solution/blob/develop/pic-evidence/run-create-comment-issue.png)

## Conclusion

The CI pipeline automates the software development process by executing various tasks, including building, testing, and analysis. It helps ensure code quality, security, and reliability throughout the development lifecycle.

![CI completed](https://github.com/DMBIAM/DevOps-solution/blob/develop/pic-evidence/run-ci-completed.png)

---

# Continuous Deployment Pipeline Overview

This document provides an overview of the Continuous Deployment (CD) pipeline named "CE" used in the development workflow of the project. Use action name `develops-solution-cd`

## Pipeline Description

The CD pipeline is responsible for automating the deployment of the application to a target environment after successful completion of the CI pipeline.

## Pipeline Structure

### Overview

The CD pipeline ensures smooth and efficient deployment of the application to the production environment.

## Conclusion

The CD pipeline plays a crucial role in the development workflow by automating the deployment process, thereby facilitating rapid and reliable delivery of software updates.

---

### Build Image ARG:

```bash
docker build \
  --build-arg USER=devops \
  --build-arg REPO=https://bitbucket.org/devsu/demo-devops-python.git \
  --build-arg PORT=8000 \
  -t devops .

docker run -d -p 8000:8000 --name devOps-solution devops