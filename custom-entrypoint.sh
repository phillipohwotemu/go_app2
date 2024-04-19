#!/bin/bash
# Ensuring Jenkins user is part of the Docker group
usermod -aG docker jenkins
# Start the Jenkins server
exec /usr/local/bin/jenkins.sh

