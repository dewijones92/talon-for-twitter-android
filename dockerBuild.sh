#!/bin/bash


CONTAINER_NAME="docker_android_build"
SECRET_DIR="/home/vagrant/release_key"
PROJECT_DIR="/project"
RELEASE_KEY_FILENAME="my-release_key.jks"
KEYSTORE_FILE_NAME="keystore.properties"
echo "111"
echo "$SECRET_DIR/$RELEASE_KEY_FILENAME"
echo "222"


#	-v "$SECRET_DIR/$RELEASE_KEY_FILENAME":"$PROJECT_DIR/$RELEASE_KEY_FILENAME":ro \
#	-v "$SECRET_DIR/$KEYSTORE_FILE_NAME":$PROJECT_DIR/$KEYSTORE_FILE_NAME:ro \

docker run -it -d --name $CONTAINER_NAME \
	-v "$SECRET_DIR/$RELEASE_KEY_FILENAME":"$PROJECT_DIR/$RELEASE_KEY_FILENAME":ro \
	-v "$SECRET_DIR/$KEYSTORE_FILE_NAME":$PROJECT_DIR/$KEYSTORE_FILE_NAME:ro \
	-v gradle:"/root/.gradle" -v `pwd`:$PROJECT_DIR jangrewe/gitlab-ci-android  bash

docker exec -it $CONTAINER_NAME bash -c 'export GRADLE_USER_HOME=/root/.gradle; cd /project; chmod +x ./gradlew; echo "KEYSTOREPROPS" ; cat keystore.properties; ./gradlew build' 
