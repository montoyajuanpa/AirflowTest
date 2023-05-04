##defining the base
FROM python:3.8-slim-buster
LABEL maintainer="Juan Jaramillo"
LABEL version="1.0"
LABEL description="Airflow container"

##system update
RUN apt-get update && apt-get -y upgrade && apt-get -y install libpq-dev gcc
##copy files to the container
WORKDIR /app
COPY requirements.txt .
COPY dags/ dags/
COPY plugins/ plugins/
##install dependecies 
RUN pip install --no-cache-dir -r requirements.txt
## defining environment variables
ENV AIRFLOW_HOME=/app
ENV PYTHONPATH=$PYTHONPATH:/app
ENV TZ=UTC

EXPOSE 8080
#start server
CMD ["airflow", "webserver"]

docker build -t airflow-image .

docker run -d -p 8080:8080 --name airflow-container airflow-image
