#!/bin/bash
docker run --name docker_android_build -v gradle:"/root/.gradle" -v `pwd`:/project mingc/android-build-box  bash -c 'cd /project; ./gradlew build'
