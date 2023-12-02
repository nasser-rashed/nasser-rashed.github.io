#! /bin/bash

for srv  in $(cat getent86.out.f.toberemoved|awk '{print $1}')
do
  ./portscanning.sh $srv && echo $srv
done > getent86.out.temp.f.toberemoved

for srv in $(cat getent86.out.temp.f.toberemoved)
do 
  grep $srv getent86.out.f.toberemoved >> getent86.out.refined.f.toberemoved
done

awk '!seen[$2]++' getent86.out.refined.f.toberemoved > getent86.out.f.toberemoved
#cp getent86.out.refined.f.toberemoved getent86.out.f.toberemoved
#mv getent86.out.refined.f.toberemoved getent86.out.f.toberemoved

rm getent86.out.temp.f.toberemoved getent86.out.refined.f.toberemoved
