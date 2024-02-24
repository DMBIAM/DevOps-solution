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
2. **Set up QEMU**: Configures QEMU for the Ubuntu 20.04 environment using the `docker/setup-qemu-action@v3` action.
3. **Set up Docker Buildx**: Sets up Docker Buildx for building Docker images using the `docker/setup-buildx-action@v3` action.
4. **Login to Docker Hub**: Authenticates with Docker Hub using the `docker/login-action@v3` action.
5. **Build and not push Docker image**: Builds a Docker image without pushing it to the registry. It includes build arguments such as user, repository, and port.
6. **Run Unit Tests**: Executes unit tests using the Python `manage.py test` command in a Docker container.
7. **Static Code Analysis**: Performs static code analysis using pylint in a Docker container.
8. **Code Coverage**: Runs code coverage analysis using pytest and generates a coverage report.
9. **Run Bandit for security analysis**: Conducts security analysis using Bandit in a Docker container.
10. **Generate Failure Comment**: Generates a failure comment if any of the previous steps fail. It creates an issue comment with details about the failed step, workflow, actor, run ID, SHA, and a link to the pipeline run for further verification.

## Conclusion

The CI pipeline automates the software development process by executing various tasks, including building, testing, and analysis. It helps ensure code quality, security, and reliability throughout the development lifecycle.

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
