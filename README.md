[![CircleCI](https://dl.circleci.com/status-badge/img/gh/RazorbreakRZ/project-ml-microservice-kubernetes/tree/main.svg?style=svg)](https://dl.circleci.com/status-badge/redirect/gh/RazorbreakRZ/project-ml-microservice-kubernetes/tree/main)

## Project Overview

In this project, I'm applying the skills I have acquired during this course to operationalize a Python Machine Learning Microservice API. 

Using a pre-trained, `sklearn` model that has been trained to predict housing prices in Boston according to several features, such as average rooms in a home and data about highway access, teacher-to-pupil ratios, and so on. This data model was initially taken from Kaggle, on [the data source site](https://www.kaggle.com/c/boston-housing). This project tests your ability to operationalize a Python flask app—in a provided file, `app.py`—that serves out predictions (inference) about housing prices through API calls. This project could be extended to any pre-trained machine learning model, such as those for image recognition and data labeling.

### Project Tasks

The project goal is to operationalize this working, machine learning microservice using [kubernetes](https://kubernetes.io/), which is an open-source system for automating the management of containerized applications. In this project you will:
* Test the project code using linting
* Complete a Dockerfile to containerize this application
* Deploy a containerized application using Docker and make a prediction
* Improve the log statements in the source code for this application
* Configure Kubernetes and create a Kubernetes cluster
* Deploy a container using Kubernetes and make a prediction
* Upload a complete Github repo with CircleCI to indicate that the code has been tested

Find a detailed [project rubric, here](https://review.udacity.com/#!/rubrics/2576/view).

---

## Setup the Environment

* Create a virtualenv with Python 3.7 and activate it. Refer to this link for help on specifying the Python version in the virtualenv. 
```bash
python3 -m pip install --user virtualenv
# You should have Python 3.7 available in your host. 
# Check the Python path using `which python3`
# Use a command similar to this one:
python3 -m virtualenv --python=<path-to-Python3.7> .devops
source .devops/bin/activate
```
* Run `make install` to install the necessary dependencies

### Running `app.py`

1. Standalone:  `python app.py`
2. Run in Docker:  `./run_docker.sh`
3. Run in Kubernetes:  `./run_kubernetes.sh`

### Make a prediction
To run a prediction against the container, execute the script `./make_prediction.sh`. This will make a `POST` request to `/predict` endpoint of the service, passing the header `Content-Type: application/json` and following JSON body:
```json
{  
    "CHAS":{  
        "0":0
    },
    "RM":{  
        "0":6.575
    },
    "TAX":{  
        "0":296.0
    },
    "PTRATIO":{  
        "0":15.3
    },
    "B":{  
        "0":396.9
    },
    "LSTAT":{  
        "0":4.98
    }
}
```
### Docker & Kubernetes Steps

#### Setup Docker locally
To setup Docker locally, it's recommended to follow the installation guidelines in official documentation https://docs.docker.com/engine/install/ based on your OS.

#### Setup Kubernetes locally
- If you already have Docker Desktop, simply enable the Kubernetes cluster following the official guide at https://docs.docker.com/desktop/kubernetes/
- For other OS, I refer to Minikube, as it's the second easiest way to deploy your local cluster. Link at https://minikube.sigs.k8s.io/docs/start/
- Or if you wan't to try a real k8s cluster on AWS, refer to *eksctl* to deploy one quickly in your own account. More details at https://eksctl.io/introduction/

Additionally, **kubectl** will be also required to run the k8s scripts provided in the project. You will need to follow the steps based on your own OS (linux, mac or windows). More details at https://kubernetes.io/docs/tasks/tools/
#### Build docker container with Flask App
To build the docker image with the containerized application, you can execute the following docker command from the root folder of the repository:
```bash
docker build --tag ml-microservice-kubernetes:latest .
```
Optionally, you can also simply execute the `run_docker.sh` script to build and run the newly created container on port `8080`.
#### Run via kubectl
Once **kubectl** is configured against your k8s cluster, to run the container as a pod you will need to execute the following commands:
```bash
kubectl run ml-microservice-kubernetes --image=ml-microservice-kubernetes:latest --port=80 --labels app=ml-microservice-kubernetes

kubectl port-forward ml-microservice-kubernetes 8000:80
```
This will publish the pod on port `8000`. Optional, the script `run_kubernetes.sh` do the same procedure.

Keep in mind that for its usage on a non-local cluster, the image must be `pushed` to a docker registry, like DockerHub or AWS ECR. The `upload_docker.sh` script provides a sample to upload the image to DockerHub. More info about this topic at https://docs.docker.com/get-started/04_sharing_app/
### Kubernetes logs
For logging purposes, an extra script `./logs_kubernetes.sh` follows the log output of the POD once it's up and running.

### Cleanup
To delete the pod, you can run the following command:
```bash
kubectl delete pod/ml-microservice-kubernetes
```
