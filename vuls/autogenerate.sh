#!/bin/bash  

if ! [ -f /usr/bin/telnet ]; then
    echo "Telnet does not exist."
    exit 1
fi
rm -rf getent86.out.f.toberemoved
rm -rf ./sshable.h uniq-sshable temp.f.toberemoved  uniq-sshable-h

echo 'Starting ... Be patient!'

cat  > temp.f.toberemoved << EOF ### temp file for config

[servers]

[servers.localhost]
host = "localhost"
port = "local" 
EOF

networkid=$(/usr/bin/hostname -I    | awk '{print $1}' | awk -F. '{print $1,$2,$3}'|tr " " ".")
## Echo pingable Addresses  ##
echo $networkid
for srv in $(seq 1 254); do ./pingable.sh $networkid.$srv && ./portscanning.sh $networkid.$srv && echo $networkid.$srv  & 
done  >> ./sshable.h 
sleep 4
cat ./sshable.h |sort -u  >> uniq-sshable
cat uniq-sshable |while read ip
do 
hostname=$(ssh -i ~saua/.ssh/id_rsa saua@$ip  "uname -n" </dev/null)
cat >> uniq-sshable-h << EOF
$ip  $hostname
EOF
done
cat uniq-sshable-h |while read ip hostname
do
#hostname=$(ssh -i ~saua/.ssh/id_rsa saua@$ip  "uname -n" </dev/null)
cat >> temp.f.toberemoved << EOF
[servers.$hostname]
host = "$ip"
port = "22"
user = "saua"
keyPath = "/home/saua/.ssh/id_rsa"
EOF
done
cp  --backup temp.f.toberemoved config.toml
sed  -i '3,$s/^/#/' /etc/hosts
cp /etc/hosts /etc/hosts-$$
cat   uniq-sshable-h >> /etc/hosts
echo 'completed run vuls scan '
: '
do timeout 2s ping -w1  $networkid.$srv > /dev/null && echo "quit" | telnet  $networkid.$srv 22 >/dev/null  && echo $networkid.$srv ; done  # > getent86.out.f.toberemoved
for srv in $(seq 1 255); do timeout 10s ping -w1  $networkid.$srv ; done > getent86.out.f.toberemoved
#for srv in $(seq 1 255); do getent hosts 192.168.0.$srv; done > getent0.out.f.toberemoved

echo 'running clean up files'
./cleangetent.sh # getent86.out.f.toberemoved getent0.out.f.toberemoved
echo 'finish clean up files'
 

cat getent* 
sleep 20
cat getent*|while read a b
do
cat >> temp.f.toberemoved << EOF
[servers.$b]
host = "$a"
port = "22"
user = "saua"
keyPath = "/home/saua/.ssh/id_rsa"
EOF

#timeout 20s /usr/bin/ssh-keyscan -p 22  $a 
timeout 20s /usr/bin/ssh-keyscan -p 22 $a >> ~/.ssh/known_hosts
#/usr/bin/ssh -i /home/saua/.ssh/id_rsa -p 22 -l saua 192.168.86.36
done


cp  --backup temp.f.toberemoved config.toml

rm  -rf *.f.toberemoved*

sed -i   "s/\.lan//g" config.toml
'
