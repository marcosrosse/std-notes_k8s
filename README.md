# Minhas anotacoes sobre Kubernetes
Comando Kubernetes:
kubectl explain node, pod, services, etc...
Recuperar token
  kubeadm token create --print-join-command

Add-ons:
https://kubernetes.io/docs/concepts/cluster-administration/networking/
https://chrislovecnm.com/kubernetes/cni/choosing-a-cni-provider/
https://kubernetes.io/docs/concepts/cluster-administration/addons/

Get de nodes, namespaces, etc
  kubectl get nodes
  
  kubectl get nodes nomeDoNode

  kubectl get nodes nomeDoNode -o wide (traz infos uteis do node)
  
  kubectl get pods, namespace, service ou qualquer outro recurso nome-do-recurso -o yaml (exporta yaml para criar um recurso a partir de um recurso existente)


Describe de qualquer subcomando do kubectl
  kubectl describe nodes

Criar um pod, namespace, etc
  kubectl run nginx --image=nginx
  
  kubectl create -f meu-pod.yaml

  kubectl create namespace meuNameSpace

  kubectl run nginx --image=nginx --dry-run=client -o yaml ou kubectl run nginx --image nginx --namespace web --port 80 --dry-run=client -o  yaml  > nginx.yml

	  apiVersion: v1
	kind: Pod
	metadata:
	  creationTimestamp: null
	  labels:
	    run: nginx
	  name: nginx
	spec:
	  containers:
	  - image: nginx
	    name: nginx
	    resources: {}
	    ports:
	    - containerPort: 80
	  dnsPolicy: ClusterFirst
	  restartPolicy: Always
	status: {}

Expor um pod (criando um service)
  
  kubectl expose pod nginx (apenas quando o pod tem um containerPort configurado. A  partir do momento que fizer isso, ele criara um service deste meu pod)

  kubectl describe service nginx

Escalar meu deployment
  
  kubectl -n meunamespace scale deployment/simpleapp-deployment --replicas=10

Atualizar a versao  de uma ou mais imagens do meu deployment
  
  kubectl set image deployment/simpleapp-deployment (esse simpleapp-python eh o name da spec containers) simpleapp-python=marcosrossem/simple-app-python:versaoX
