#!/bin/bash
echo "creating project for nginx block test"
oc new-project nginx-block
echo "adding policy to allow priviledged"
oc adm policy add-scc-to-user anyuid -z default --as=system:admin
echo " deploying block template"
for nu in {1..10};do oc process -f ./ocs4-block-test-template.yaml |oc create -f - ;done

echo "======================================================================================================="
echo "=                                                                                                     ="
echo "=                                                                                                     ="
echo "=                                     sleeping 2 minutes to settle                                    ="
echo "=                                                                                                     ="
echo "=                                                                                                     ="
echo "======================================================================================================="
sleep 120
echo
echo
echo "creating project for nginx file test"
oc new-project nginx-file
echo "adding policy to allow priviledged"
oc adm policy add-scc-to-user anyuid -z default --as=system:admin
echo " deploying file template"
for nu in {1..10};do oc process -f ./ocs4-file-test-template.yaml |oc create -f - ;done
