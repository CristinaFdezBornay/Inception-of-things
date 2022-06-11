echo "=== CONFIGURATION WORKER ==="

echo "==> FIX YUM"
sed -i 's/mirrorlist/#mirrorlist/g' /etc/yum.repos.d/CentOS-*
sed -i 's|#baseurl=http://mirror.centos.org|baseurl=http://vault.centos.org|g' /etc/yum.repos.d/CentOS-*

echo "==> DISABLE FIREWALL"
sudo systemctl disable firewalld --now

echo "==> INSTALLATION IFCONFIG"
sudo yum update -y
sudo yum install -y net-tools

echo "==> INSTALLATION K3S"

echo "=> Copy Token"
USER='cristina'
USER_IP='192.168.1.150'
TOKEN_FILE='/var/lib/rancher/k3s/server/node-token'

echo "=> Copy Token"
VM_SSH_KEY_PRIVATE=$1
USER_NAME=$2
USER_IP=$3
USER_TOKEN_FILE=$4

scp -o StrictHostKeyChecking=accept-new -i $VM_SSH_KEY_PRIVATE $USER_NAME@$USER_IP:$USER_TOKEN_FILE . 

echo "=> Download and install k3s"
SERVER_IP=$5

curl -sfL https://get.k3s.io | K3S_URL="https://$SERVER_IP:6443" K3S_TOKEN=`sudo cat node-token` sh -s - --flannel-iface=eth1

echo "=== CONFIGURATION WORKER OK ==="
