#!/bin/bash

# Start IAP tunnel, if not already running
if [[ $(sudo netstat -tulpn | grep LISTEN | grep :$2) ]]; then
    echo "IAP tunnel is already open and listening on $2"
else
    echo "Starting IAP tunnel on port $2"
    gcloud compute start-iap-tunnel %1 3389 --local-host-port=localhost:%2 --zone=europe-north1-a --project=visma-274514 &
    sleep 3
fi