# K8s Tools Dockerfile

Just a simple container that runs some K8s tooling to help with some CI projects I am working on and an excure to play around with Github Actions.

## Using the container

### Conftest

`docker run conftest test myfile.yaml`

### Kubectl

`docker run kubectl -f myfile.yaml`

### KubeVal

`docker run kubeval myfile.yaml`