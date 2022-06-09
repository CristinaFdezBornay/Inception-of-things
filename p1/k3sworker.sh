echo "=== SCRIPT PROVISION WORKER ==="

echo "==> FIXING YUM"
sudo sed -i 's/mirrorlist/#mirrorlist/g' /etc/yum.repos.d/CentOS-*
sudo sed -i 's|#baseurl=http://mirror.centos.org|baseurl=http://vault.centos.org|g' /etc/yum.repos.d/CentOS-*

# echo "==> INSTALLING k3s"

# echo "=> Copy token"
# OUR_IP=192.168.42.1
# scp -o StrictHostKeyChecking=accept-new -i /home/vagrant/.ssh/id_rsa adricristi@$OUR_IP:~/Inception-of-things/p1/node-token . 

# echo "=> Download and configure k3s"
# SERVER_IP=192.168.42.110
# curl -sfL https://get.k3s.io | K3S_URL=https://$SERVER_IP:6443 K3S_TOKEN=`sudo cat node-token` sh -

# echo "==> INSTALLATION COMPLETED"
