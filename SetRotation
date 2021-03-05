#!/bin/bash

filename=$1
period="90d"
period_1d="86400s"
rotation_time=$(date --date="+30 days" --utc --rfc-3339=seconds)
echo $rotation_time
location="northamerica-northeast1"
project_id="charged-atlas-268821"
keyring="MY-KEY-Ring"
key="ugochi-test"

 

#Check the file exists
if [ -f "$filename" ]; then
    echo "$filename will be used for setRotation.sh"
else
    echo "$filename does not exist. Exiting"
    exit -1
fi

while read project_id; do
    # reading each line
    current_rotation_time=`gcloud kms keys describe $key --project=$project_id --keyring=$keyring --location=$location --format="value(rotationPeriod)"`
    if [ $current_rotation_time = $period_1d ]; then
        echo Updating expiry period: $project_id
        gcloud kms keys set-rotation-schedule $key --project=$project_id --location=$location --keyring=$keyring  --rotation-period=$period  --next-rotation-time="$rotation_time"
        gcloud kms keys describe $key --project=$project_id --keyring=$keyring  --location=$location   
    fi
done < $filename
