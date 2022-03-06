#!/bin/bash
source ./start-script/startconf.sh

export JAVA_HOME=/usr/lib/jvm/java-$JAVA_VER-openjdk-amd64
export PATH=$JAVA_HOME/bin:$PATH

if [ -z "$JAR_NAME" ]; then
  FILELIST=($(ls .. | egrep "((waterfall)|(paper)|(spigot)).*\.jar"))
  if [[ ${#FILELIST[@]} > 1 ]]; then
    echo "(!) More than 1 JARs exist! Remove unused JARs or specify JAR_NAME before continue!"
    exit 1;
  else
    JAR_NAME=${FILELIST[0]}
  fi
fi

print_info(){
  echo "====================="
  echo Memory: $MEMORY
  echo JAR: $JAR_NAME
  echo Java: $JAVA_HOME
  echo "======================"
}

start_server() {
  java -Xmx$MEMORY $ARGS -jar $JAR_NAME;
  read -t 10 -p "Restarting in 10 Seconds (Press ENTER to restart now / Ctrl-C to terminate)"
  clear
  start_server
}

echo $(pwd)
print_info
echo $(pwd)
start_server
