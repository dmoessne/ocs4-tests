# ocs4-tests

- WIP - 20200903 - initial


This project is intended to mass deploy OCS 4 cephfs and/or block volumes that are used by nginx containers which are in turn exposed via a route and announce their pod name.
For testing purposes and to demonstrate the backing store is working, every pod restart, i.e. deleting the pods, adds its pod name again to index.html 

The container image used `quay.io/dmoessne/fedora-nginx:0.2` is build upon `fedora-minimal` image. To build own image, steps can be found in the `image` folder to create it on your own.

This image is used in 2 templates, one for file and one for block storage usage, named:
  - `ocs4-file-test-template.yaml`
  - `ocs4-block-test-template.yaml`

Those templates automatically create random names, so one does not need to take care of it, however the templates allow the usual variable substitution during creation (`oc process
-f <filename> -e <VAR>=<VALUE>`) if needed. Further on, the template assumes the out of the box names for OCS4 storage classesi are used (not external yet) which need to be adjusted 
if default storage class names have been altered or different ones are/should be used. 

To make life easier, the repo also has 2 scripts available for an easy kickstart:
  - `liftoff.sh`
     This one just creates 2 namespaces `nginx-block` and `nginx-file` and creates 10 containers in each using either block or file

  - `liftoff-mod.sh`
     This is quite flexible and can create either file or block or both with a variable amount of namespaces and pods, usage as follows:
 ~~~
./liftoff-mod.sh

You need to give 3 arguments:
   1:  for Number of Namespaces to be created (#-NS)
   2:  for Number of Pods per Namespace (#-PO)
   3:  which type: b for block, f for file, a for all
Usage: liftoff-mod.sh #-NS #-PO type

~~~

To quick'n dirty cleanup I simply use:
  - `oc get project |awk '/nginx-/ {print$1}'`   check for existing namespaces
  - `oc get project |awk '/nginx-/ {print$1}' |xargs oc delete project ` to remove them. This might take some time and be careful if you have projects starting with `nginx`
 
