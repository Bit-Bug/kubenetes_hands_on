#!/bin/bash
if [[ ! $(gcloud config get-value account &> /dev/null) ]]
then
    gcloud auth login 
    if [ -z $GOOGLE_APPLICATION_CREDENTIALS ]
    then
        echo $GCP_SA_KEY > google-app-creds.json
        echo Enter your prject ID :
        read projectID
	echo Enter your cluster Name :
	read clusterName
	echo Enter number of nodes per cluster:
	read nodeNumber
	gcloud container clusters create  $clusterName --num-nodes $nodeNumber  --region us-central1-c --project $projectID
	kubectl create -f mypod.yaml
	kubectl describe pods
	kubectl describe pod.spec
	kubectl get po kubia-manual -o yaml
	kubectl get po kubia-manual -o json
    fi
fi
