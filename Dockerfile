FROM python:3.7.3-stretch

LABEL Name="ml-microservice-kubernetes"
LABEL Version="1.0.0"

## Step 1:
# Create a working directory
WORKDIR /app

## Step 2:
# Copy source code to working directory
COPY model_data/boston_housing_prediction.joblib /app/model_data/boston_housing_prediction.joblib
COPY requirements.txt /app/
COPY app.py /app/

## Step 3:
# Install packages from requirements.txt
RUN pip install -r requirements.txt
# hadolint ignore=DL3013

## Step 4:
# Expose port 80
EXPOSE 80

## Step 5:
# Run app.py at container launch
ENTRYPOINT [ "python", "app.py" ]
