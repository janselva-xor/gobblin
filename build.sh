#!/bin/bash
#
# Important note
# 
# This build runs Hadoop unit tests which can require substantial resources
# 
# It has been tested on:
# AWS m3.large instance (2 CPUs, 7.5GB memory and 32GB SSD storage)
# AMI: ubuntu/images/hvm-ssd/ubuntu-trusty-14.04-amd64-server-20160714 (ami-ed82e39e)
#
# On the above instance type the build & tests complete in under 7 mins
#
# Please check pnda-build/ for the build products

VERSION=${1}

function error {
    echo "Not Found"
    echo "Please run the build dependency installer script"
    exit -1
}

echo -n "Gradle: "
if [[ $(gradle --version 2>&1) != *"Gradle 1.4"* ]]; then
    error
else
    echo "OK"
fi

echo -n "Java 1.8.0_74: "
if [[ $($JAVA_HOME/bin/javac -version 2>&1) != "javac 1.8.0_74" ]]; then
    error
else
    echo "OK"
fi

mkdir -p pnda-build
HADOOP_VERSION=2.6.0-cdh5.5.2
./gradlew build -Pversion=${VERSION} -PhadoopVersion=${HADOOP_VERSION} -PexcludeHadoopDeps -PexcludeHiveDeps -x gobblin-core:test
mv gobblin-distribution-${VERSION}.tar.gz pnda-build/
sha512sum pnda-build/gobblin-distribution-${VERSION}.tar.gz > pnda-build/gobblin-distribution-${VERSION}.tar.gz.sha512.txt