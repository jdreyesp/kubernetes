#minikube
#==========
minikube start
minikube stop
ssh 192.168.99.100
minikube addons list
minikube addons enable ingress

#Docker
#==========
docker run jdiegoreyes/busybox:v.4.1.0 echo "Hello, world"

#Kubernetes
#==========

kubectl run kubia --image=jdiegoreyes/kubia --port=8080 --generator=run/v1 #deploy image to kubernetes

#query
kubectl get rc
kubectl api-resources
kubectl get nodes
kubectl get service
kubectl get pods -o wide # Shows pod IPs

#info
kubectl explain pods #get all help for pods
kubectl describe node minikube
kubectl get po --all-namespaces

#labels
kubectl get po --show-labels
kubectl get po -L creation_method,env
kubectl label po kubia-manual creation_method=manual
kubectl label po kubia-manual-v2 env=debug --overwrite

#RC and RS
kubectl expose rc kubia --type=LoadBalancer --name kubia-http
kubectl scale rc kubia --replicas=3

#creation
kubectl create -f kubia-manual-with-labels.yaml

#expose services
kubectl port-forward kubia-manual 8888:8080 #kubia-manual is a pod
kubectl -f create kubia-svc.yaml #nodeport service
#Access ingress via: https://kubia.example.com/

#security
1.openssl genrsa -out tls.key 2048
2.openssl req -new -x509 -key tls.key -out tls.cert -days 360 -subj /CN=kubia.example.com
3.kubectl create secret tls tls-secret --cert=tls.cert --key=tls.key