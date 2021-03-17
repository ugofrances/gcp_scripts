
git clone --depth 1 --branch main git@github.com:ugofrances/gcp_scripts
 

#Select the correct directory

cd gcp_scripts/scripts

#Invoke the scripts

./destroyKeys.sh data/file.txt

./setRotation.sh data/file.txt
