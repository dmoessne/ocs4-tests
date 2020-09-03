#!/bin/bash
echo
if [ "$#" -ne 3 ]; then
   echo "You need to give 3 arguments:"
   echo "   1:  for Number of Namespaces to be created (#-NS)"
   echo "   2:  for Number of Pods per Namespace (#-PO)"
   echo "   3:  which type: b for block, f for file, a for all"
   echo "Usage: `basename $0` #-NS #-PO type"
   echo
   exit
fi

function block {
clear
echo block
echo "****"
for i in $(seq 1 $1); do
  echo "creating project for nginx-block-$i"
  oc new-project nginx-block-$i
  echo "adding policy to allow priviledged"
  oc adm policy add-scc-to-user anyuid -z default --as=system:admin
  for j in $(seq 1 $2); do
    echo "deploying block template"
    oc process -f ./ocs4-block-test-template.yaml |oc create -f -
  done
  echo "sleeping 60 seconds to settle"
  sleep 60
done
}

function file {
clear
echo file
echo "****"
for i in $(seq 1 $1); do
  echo "creating project for nginx-file-$i"
  oc new-project nginx-file-$i
  echo "adding policy to allow priviledged"
  oc adm policy add-scc-to-user anyuid -z default --as=system:admin
  for j in $(seq 1 $2); do
    echo "deploying file template"  
    oc process -f ./ocs4-file-test-template.yaml |oc create -f -
  done
  echo "sleeping 60 seconds to settle"
  sleep 60
done
}
case "$3" in 
  b) block $1 $2 ;;
  f) file  $1 $2;;
  a) block $1 $2
     file  $1 $2;;
esac

