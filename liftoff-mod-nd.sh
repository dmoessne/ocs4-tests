#!/bin/bash
echo
if [ "$#" -ne 2 ]; then
   echo "You need to give 2 arguments:"
   echo "   1:  for Number of Namespaces to be created (#-NS)"
   echo "   2:  for Number of Pods per Namespace (#-PO)"
   echo "Usage: `basename $0` #-NS #-PO"
   echo
   exit
fi

clear
echo "creating $1 NAMESPACES with $2 PODS"
echo "****"
for i in $(seq 1 $1); do
  NAMESPACE_ID=$(uuidgen)
  echo "creating project for nginx-nd-${NAMESPACE_ID}"
  oc new-project nginx-nd-${NAMESPACE_ID}
  echo "adding policy to allow priviledged"
  oc adm policy add-scc-to-user anyuid -z default --as=system:admin
  for j in $(seq 1 $2); do
    echo "deploying template"  
    oc process -f ./ocs4-test-template-nd.yaml |oc create -f -
  done
#  echo "sleeping 2 seconds to settle"
#  sleep 2
done
