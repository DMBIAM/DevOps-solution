<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Continuous Integration Pipeline Overview</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            line-height: 1.6;
            margin: 0;
            padding: 20px;
        }

        h1 {
            text-align: center;
            margin-bottom: 20px;
        }

        h2 {
            margin-top: 30px;
        }

        p {
            margin-bottom: 10px;
        }

        ul {
            list-style-type: none;
            padding: 0;
            margin: 0;
        }

        li {
            margin-bottom: 10px;
        }

        .container {
            max-width: 800px;
            margin: auto;
        }

        .section {
            margin-bottom: 40px;
        }

        .code {
            background-color: #f4f4f4;
            padding: 10px;
            overflow-x: auto;
        }

        .comment {
            background-color: #f9f9f9;
            border-left: 6px solid #ccc;
            padding: 10px;
            margin-bottom: 20px;
        }

        .link {
            color: blue;
            text-decoration: underline;
            cursor: pointer;
        }
    </style>
</head>

<body>
    <div class="container">
        <h1>Continuous Integration Pipeline Overview</h1>

        <div class="section">
            <h2>Overview</h2>
            <p>This document provides an overview of the Continuous Integration (CI) pipeline named "CI" used in the development workflow of the project. Use action file develops-solution-ci.yml</p>
        </div>

        <div class="section">
            <h2>Pipeline Description</h2>
            <p>The CI pipeline is triggered on every push to the "develop" branch of the repository. It runs a series of jobs on the Ubuntu 20.04 environment to automate various stages of the software development lifecycle.</p>
        </div>

        <div class="section">
            <h2>Pipeline Structure</h2>

            <div class="section">
                <h3>Permissions</h3>
                <p>The pipeline requires specific permissions to perform certain actions within the repository. These permissions include:</p>
                <ul>
                    <li>Contents: Write access to repository contents.</li>
                    <li>Pull Requests: Write access to create and update pull requests.</li>
                    <li>Issues: Write access to create issues.</li>
                    <li>ID-Token: Write access for token management.</li>
                </ul>
            </div>

            <div class="section">
                <h3>Jobs</h3>
                <p>The CI pipeline consists of a single job named "build" which is responsible for executing the following steps:</p>
                <ol>
                    <li>Checkout code: Fetches the latest code from the repository using the actions/checkout@v3 action.</li>
                    <li>Set up QEMU: Configures QEMU for the Ubuntu 20.04 environment using the docker/setup-qemu-action@v3 action.</li>
                    <li>Set up Docker Buildx: Sets up Docker Buildx for building Docker images using the docker/setup-buildx-action@v3 action.</li>
                    <li>Login to Docker Hub: Authenticates with Docker Hub using the docker/login-action@v3 action.</li>
                    <li>Build and not push Docker image: Builds a Docker image without pushing it to the registry. It includes build arguments such as user, repository, and port.</li>
                    <li>Run Unit Tests: Executes unit tests using the Python manage.py test command in a Docker container.</li>
                    <li>Static Code Analysis: Performs static code analysis using pylint in a Docker container.</li>
                    <li>Code Coverage: Runs code coverage analysis using pytest and generates a coverage report.</li>
                    <li>Run Bandit for security analysis: Conducts security analysis using Bandit in a Docker container.</li>
                    <li>Generate Failure Comment: Generates a failure comment if any of the previous steps fail. It creates an issue comment with details about the failed step, workflow, actor, run ID, SHA, and a link to the pipeline run for further verification.</li>
                </ol>
            </div>
        </div>

        <div class="section">
            <h2>Conclusion</h2>
            <p>The CI pipeline automates the software development process by executing various tasks, including building, testing, and analysis. It helps ensure code quality, security, and reliability throughout the development lifecycle.</p>
        </div>
    </div>

    <div class="container">
        <h2 style="text-align: center;">Continuous Deployment Pipeline Overview</h2>

        <div class="section">
            <h2>Overview</h2>
            <p>This document provides an overview of the Continuous Deployment (CD) pipeline named "CE" used in the development workflow of the project. Use action name develops-solution-cd</p>
        </div>
    </div>

    
</body>

</html>


Build Image ARG: 

docker build \
  --build-arg USER=devops \
  --build-arg REPO=https://bitbucket.org/devsu/demo-devops-python.git \
  --build-arg PORT=8000 \
  -t devops .

Launch container: docker run -d -p 8000:8000 --name devOps-solution devops