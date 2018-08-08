yyyymmdd=$1

if [ -n "$yyyymmdd" ]; then
  echo 'Input Parameter : '$yyyymmdd

  echo 'tomcat stop ----------------------------------------- '
  ../tomcat/bin/shutdown.sh

  echo 'original www back ----------------------------------------- '
  mv ../www ../www_back/www_$1

  mv ../www.war ../www_back/www_$1.war
  
  echo 'war move ----------------------------------------- '
  mv lms.war ../www.war
 
  echo 'tomcat start ----------------------------------------- '
  ../tomcat/bin/startup.sh
else
  echo 'parameter input'
fi
