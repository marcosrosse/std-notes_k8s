{
 "exec-opts": ["native.cgroupdriver=systemd"],
 "log-driver": "json-file",
 "log-opts": {
   "max-size": "100m"
 },
 "storage-driver": "overlay2"
}

kubeadm init --cri-socket /run/containerd/containerd.sock

mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config


modprobe br_netfilter ip_vs_rr ip_vs_wrr ip_vs_sh nf_conntrack_ipv4 ip_vs

kubectl apply -f "https://cloud.weave.works/k8s/net?k8s-version=$(kubectl version | base64 | tr -d '\n')"

kubeadm join 192.168.0.33:6443 --token kn2yq9.spf12ajsun0fdxsz \
    --discovery-token-ca-cert-hash sha256:417ed26552ac2cfa36372eb6c6fa6dbd4a7de62827eddedac7e68f9e8fcc44d1

# vim /etc/modules-load.d/k8s.conf
br_netfilter
ip_vs_rr
ip_vs_wrr
ip_vs_sh
nf_conntrack_ipv4
ip_vs


# apt-get update -y && apt-get upgrade -y

# curl -fsSL https://get.docker.com | bash

# apt-get update && apt-get install -y apt-transport-https

# curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -

# echo "deb http://apt.kubernetes.io/ kubernetes-xenial main" > /etc/apt/sources.list.d/kubernetes.list

# apt-get update

# apt-get install -y kubelet kubeadm kubectl

# swapoff -a

# vim /etc/fstab

# kubeadm config images pull

# kubeadm init

# mkdir -p $HOME/.kube

# sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config

# sudo chown $(id -u):$(id -g) $HOME/.kube/config

# kubectl apply -f "https://cloud.weave.works/k8s/net?k8s-version=$(kubectl version | base64 | tr -d '\n')"

# kubectl get pods -n kube-system

# kubeadm join --token 39c341.a3bc3c4dd49758d5 IP_DO_MASTER:6443 --discovery-token-ca-cert-hash sha256:37092 

# kubectl get nodes

# kubectl describe node elliot-03

# kubeadm token create --print-join-command

# echo "source <(kubectl completion bash)" >> ~/.bashrc

# kubectl get namespace

# kubectl get pods -n kube-system

# kubectl get pods --all-namespaces

# kubectl run nginx --image nginx

# kubectl get deployments

# kubectl describe deployment nginx

# kubectl get events

# kubectl get deployment nginx -o yaml

# kubectl get deployment nginx -o yaml > meu_primeiro.yaml

# kubectl delete deployment nginx

# kubectl create -f meu_primeiro.yaml

# kubectl delete -f meu_primeiro.yaml

# kubectl get deploy,pod

# kubectl expose deployment/nginx

# kubectl get svc nginx 

# kubectl describe pod nginx-6f858d4d45-qxjlh

# kubectl get pods -o wide

# kubectl delete pods nginx-6f858d4d45-qxjlh

Comando Kubernetes:

kubectl explain node, pod, services, etc...

Recuperar token
  kubeadm token create --print-join-command

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

  kubectl run nginx --image=nginx --dry-run=client -o yaml

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
  
  kubectl expose pod nginx (apenas quando o pod tem um containerPort configurado)

  kubectl describe service nginx

  