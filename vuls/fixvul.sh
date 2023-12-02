#!/bin/bash 
function pr()
{
  echo "==>" $*
}
scanflag=0
for arg in "$@"
do 
  if [ "$arg" == "-u" ]  ||  [ "$arg" == "--update" ]
   then
     ./update-all.sh 
  fi

  if [ "$arg" ==  "-g" ]  || [ "$arg" == "--generate" ]
   then
    ./autogenerate.sh 
  fi
  if [ "$arg" == "-n" ]   || [ "$arg" == "--noscan" ]
    then
     scanflag=1
  fi 
done

function scan(){
if [ "$scanflag" -eq 0 ] 
 then
   pr start scanning  at $(date +"%m/%d/%Y %H:%M") 
   pr sannning hosts : $*
   /usr/local/bin/vuls scan  $* > log.lf
   pr scanning completed! $(date +"%m/%d/%Y %H:%M")
  else
   pr skip scanning
fi
}

function fix(){
cp /dev/null ./fexecute
hosts=$*
if [[ -z $hosts ]]
then
   pr no vulneable hosts
else 
pr $hosts
for host in $(echo $hosts)
do
   os_type $host >> fexecute
done
pr start fixing at $(date +"%m/%d/%Y %H:%M")
pr running fixxing on $updatable_hosts
bash -x  ./fexecute
pr Identifing vulnerable hosts
pr  $updatable_hosts fixed at $(date +"%m/%d/%Y %H:%M")
fi
}

function os_type(){
os_type=$(ssh saua@$* -i ~saua/.ssh/id_rsa sudo uname  -a)
os_type=$(echo $os_type | grep Ubuntu >> /dev/null && echo ubuntu || echo redhat)
OSTYPE=$os_type
case "$OSTYPE" in
  ubuntu*)  echo  -e "ssh saua@$* -i ~saua/.ssh/id_rsa 'sudo sh -c \"apt-get clean all; apt-get update -y ; apt-get upgrade -y ; uname -a\"'"  ;; 
  redhat*)   echo -e "ssh saua@$* -i ~saua/.ssh/id_rsa 'sudo sh -c \"yum clean all  ; yum update -y ; uname -a\"'" ;;
  msys*)    echo "WINDOWS" ;;
  cygwin*)  echo "ALSO WINDOWS" ;;
  *)        echo "unknown: $OSTYPE" ;;
esac

}

function report(){
  echo report
}
input=$(echo "$@" | sed 's/\-[a-zA-Z]//g')
pr $input
scan $input 
echo Scan Summary
echo  ================
cat log.lf   | grep -v "0 updatable" log.lf|grep updatable
updatable_hosts=$(grep -v "0 updatable" log.lf|grep updatable |awk '{print $1}')
fix $updatable_hosts
