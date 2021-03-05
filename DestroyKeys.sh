#!/bin/bash

filename=$1
location="northamerica-northeast1"

#Check the file exists
if [ -f "$filename" ]; then
    echo "$filename will be used for setRotation.sh"
else
    echo "$filename does not exist. Exiting"
    exit -1
fi

 
while read project_id; do
    versions=`gcloud kms keys versions list --project=charged-atlas-268821 --location=northamerica-northeast1  --keyring=MY-KEY-Ring --key=ugochi-test --filter="state:ENABLED" --format="value(name)"  |  cut -d"/" -f10`
		version_array=(`echo ${versions}`);
    last_element=${#version_array[*]}-1
    # echo last_element $last_element
    max_version=${version_array[$last_element]}
    echo "Removing keys from $project_id except version $max_version"
    for version in "${version_array[@]}"
    do
        if (($version < $max_version))
        then
            gcloud kms keys versions destroy $version --project=$project_id --location=$location  --keyring=default --key=default
        else
            echo "Leaving version: $version"
        fi
    done
done < $filename
