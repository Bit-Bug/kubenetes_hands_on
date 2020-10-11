#!/bin/bash
source ~/.bashrc
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
	    kubectl create -f kubia_with_labels.yaml
	    kubectl get po --show-labels
	    kubectl get po -L creation_method,env
	    kubectl label po kubia-manual creation_method=manual
	    kubectl label po kubia-manual-v2 env=debug --overwrite
	    kubectl get po -L creation_method,env
	    kubectl get po -l creation_method=manual
	    kubectl get po -l '!env'
		 #get cluster namespaces
		kubectl get ns
		kubectl get po --namespace kube-system
		kubectl create -f kubia-manual.yaml -n custom-namespace

    fi
fi
