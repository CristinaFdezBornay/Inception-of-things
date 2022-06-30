echo "=== CONFIGURATION SERVER ==="

echo "==> FIX YUM"
sed -i 's/mirrorlist/#mirrorlist/g' /etc/yum.repos.d/CentOS-*
sed -i 's|#baseurl=http://mirror.centos.org|baseurl=http://vault.centos.org|g' /etc/yum.repos.d/CentOS-*

echo "==> DISABLE FIREWALL"
sudo systemctl disable firewalld --now

echo "==> INSTALLATION IFCONFIG"
sudo yum update -y
sudo yum install -y net-tools

echo "==> INSTALLATION K3S"

echo "=> Download and install k3s"
curl -sfL https://get.k3s.io | sh -s - server --flannel-iface=eth1 --disable traefik --disable servicelb

echo "=> Copy Token"
VM_SSH_KEY_PRIVATE=$1
SERVER_TOKEN_FILE=$2
USER_NAME=$3
USER_IP=$4
USER_TOKEN_FILE=$5

sudo scp -o StrictHostKeyChecking=accept-new -i $VM_SSH_KEY_PRIVATE $SERVER_TOKEN_FILE $USER_NAME@$USER_IP:$USER_TOKEN_FILE

echo "=== CONFIGURATION SERVER OK ==="
