# DevOps-solution

Build Image ARG: 

docker build \
  --build-arg USER=devops \
  --build-arg REPO=https://bitbucket.org/devsu/demo-devops-python.git \
  --build-arg PORT=8000 \
  -t devops .

Launch container: docker run -d -p 8000:8000 --name devOps-solution devops