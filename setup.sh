#!/bin/bash


############
#This script will setup this project.
#run ./setup.sh to RUN the project.
############

##########Define Functions##########
function installPackages(){
    local packageName=${1}
    apt-get install -y ${packageName}
    if [[ $? != 0 ]]
    then
        echo -e "\033[0;31m ${packageName} installation failed"
        exit 1
    fi
 }

if [[ $UID != 0 ]]
then
    echo -e "\033[0;31m Not a Root user"
    exit 1
fi

apt-get update

if [[ $? != 0 ]]
then
    echo "Repos not updated Successfully"
    exit 1
fi

installPackages maven
installPackages tomcat9


mvn test

if [[ $? != 0 ]]
then
    echo "MVN TEST Failed"
    exit 1
fi

mvn package

if [[ $? != 0 ]]
then
    echo "Package update Failed"
    exit 1
fi

cp -rvf target/index.html-0.0.1-SNAPSHOT.war /war/lib/tomcat9/webapps/app.war

if [[ $? != 0 ]]
then
    echo -e "\033[0;31; File not Executed"
    exit 1
fi


