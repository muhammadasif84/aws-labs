#!/bin/bash


############
#This script will setup this project.
#run ./setup.sh to RUN the project.
############

##########Define Functions##########
function installPackages(){
    local packageName=${1}
    apt-get install -y ${packageName}

    # if ! apt-get install -y ${packageName}
    # OR
    if [[ $? != 0 ]]
    then
        echo -e "\033[0;31m ${packageName} installation failed"
        exit 1
    fi
 }

##########Variables##########


if [[ $UID != 0 ]]
then
    echo -e "\033[0;31m Not a Root user"
    exit 1
fi

apt-get update

# if ! apt-get update 
#OR
if [[ $? != 0 ]]
then
    echo "Repos not updated Successfully"
    exit 1
fi

read -p "PLease Enter access path  " app_access
app_access=${app_access:-app}       # set by default value is app

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

cp -rvf target/index.html-0.0.1-SNAPSHOT.war /war/lib/tomcat9/webapps/${app_access}.war

# if ! cp -rvf target/index.html-0.0.1-SNAPSHOT.war /war/lib/tomcat9/webapps/${app_access}.war
# OR
if [[ $? != 0 ]]
then
    echo -e "\033[0;31; File not Executed"
    exit 1
fi

exit 0          
