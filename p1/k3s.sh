echo "=== SCRIPT PROVISION WORKER ==="

echo "==> FIXING YUM"
sudo sed -i 's/mirrorlist/#mirrorlist/g' /etc/yum.repos.d/CentOS-*
sudo sed -i 's|#baseurl=http://mirror.centos.org|baseurl=http://vault.centos.org|g' /etc/yum.repos.d/CentOS-*

# echo "==> INSTALLING k3s"

# echo "=> Download and configure k3s"
# curl -sfL https://get.k3s.io | sh -

# echo "=> Copy token"
# TOKEN_FILE='/var/lib/rancher/k3s/server/node-token'
# OUR_IP=192.168.42.1
# sudo scp -o StrictHostKeyChecking=accept-new -i /home/vagrant/.ssh/id_rsa $TOKEN_FILE adricristi@$OUR_IP:~/Inception-of-things/p1/

# echo "==> INSTALLATION COMPLETED"
