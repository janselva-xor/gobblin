#!/usr/bin/env bash
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


# The Gobblin tests are very thorough, resource intensive and are likely to fail
# on unsuitable build platforms. Since we're typically building to a known-good label
# default the execution of these tests to 'off'. Developers should renable.
EXCLUDES="-x test"

set -e
set -x

export LC_ALL=en_US.utf8
HADOOP_VERSION=2.6.0-cdh5.9.0

VERSION=${1}

function error {
    echo "Not Found"
    echo "Please run the build dependency installer script"
    exit -1
}

echo -n "Java 1.8: "
if [[ $($JAVA_HOME/bin/javac -version 2>&1) != "javac 1.8"* ]]; then
    error
else
    echo "OK"
fi

# The javadoc generation isn't able to take the proxy setting into consideration,
# so we disable the generation in all submodules for now.
if ! fgrep -q 'tasks.withType(Javadoc).all { enabled = false }' build.gradle; then
cat >> build.gradle << EOF

subprojects {
  tasks.withType(Javadoc).all { enabled = false }
}
EOF
fi

mkdir -p pnda-build
./gradlew clean build -Pversion="${VERSION}" -PhadoopVersion="${HADOOP_VERSION}" -PexcludeHadoopDeps -PexcludeHiveDeps ${EXCLUDES}
mv gobblin-distribution-${VERSION}.tar.gz pnda-build/
sha512sum pnda-build/gobblin-distribution-${VERSION}.tar.gz > pnda-build/gobblin-distribution-${VERSION}.tar.gz.sha512.txt
