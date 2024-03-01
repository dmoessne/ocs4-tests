#!/bin/bash
echo
if [ "$#" -ne 2 ]; then
   echo "You need to give 3 arguments:"
   echo "   1:  for Number of Namespaces to be created (#-NS)"
   echo "   2:  for Number of Pods per Namespace (#-PO)"
   echo "Usage: `basename $0` #-NS #-PO"
   echo
   exit
fi

function block {
clear
echo block
echo "****"
for i in $(seq 1 $1); do
  NAMESPACE_ID=$(uuidgen|cut -c -15)
  echo "creating project for nginx-block-${NAMESPACE_ID}"
  oc new-project nginx-block-${NAMESPACE_ID}
  echo "adding policy to allow priviledged"
  oc adm policy add-scc-to-user anyuid -z default --as=system:admin
  for j in $(seq 1 $2); do
    echo "deploying block template"
    oc process -f ./lvms-test-template.yaml |oc create -f -
  done
done
}

# main
block $1 $2
