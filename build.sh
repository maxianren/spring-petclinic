#!/bin/bash

# Set JAVA_HOME and PATH
export JAVA_HOME=/path/to/jdk17
export PATH=$JAVA_HOME/bin:$PATH

# Run Maven
mvn clean install -DskipTests
