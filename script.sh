#!/bin/bash

apt-get update -y && apt-get install -y socat ebtables conntrack

cat > /etc/modules-load.d/k8s.conf << EOF
br_netfilter
ip_vs_rr
ip_vs_wrr
ip_vs_sh
nf_conntrack_ipv4
ip_vs
EOF

cat > /etc/sysctl.d/k8s.conf << EOF
net.bridge.bridge-nf-call-ip6tables = 1
net.bridge.bridge-nf-call-iptables = 1
net.ipv4.ip_forward=1
EOF

sysctl --system

curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -

echo "deb http://apt.kubernetes.io/ kubernetes-xenial main" >> /etc/apt/sources.list

apt-get update -y

apt-get install -y kubeadm kubectl kubelet


wget -P  /tmp https://github.com/containerd/containerd/releases/download/v1.2.1/containerd-1.2.1.linux-amd64.tar.gz
tar xf /tmp/containerd-1.2.1.linux-amd64.tar.gz -C /usr/local/

wget -O /usr/local/sbin/runc https://github.com/opencontainers/runc/releases/download/v1.0.0-rc6/runc.amd64

chmod 755 /usr/local/sbin/runc

curl -o /etc/systemd/system/containerd.service https://raw.githubusercontent.com/containerd/cri/master/contrib/systemd-units/containerd.service

systemctl daemon-reload

systemctl enable containerd

systemctl start containerd

echo "runtime-endpoint: unix:///run/containerd/containerd.sock" > /etc/crictl.yaml

cat > /etc/systemd/system/kubelet.service.d/0-containerd.conf << EOF
[Service]                                                 
Environment="KUBELET_EXTRA_ARGS=--container-runtime=remote --runtime-request-timeout=15m --container-runtime-endpoint=unix:///run/containerd/containerd.sock"
EOF

systemctl daemon-reload