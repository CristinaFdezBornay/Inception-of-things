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
curl -sfL https://get.k3s.io | sh -s - server --flannel-iface=eth1
echo alias k="'sudo /usr/local/bin/kubectl'" >> .bashrc
source .bashrc

echo "=== CONFIGURATION SERVER OK ==="

echo "=== CREATING PODS ==="

for i in `seq 1 3`; do k apply -f /vagrant/confs/pod${i}.yaml; done
k apply -f /vagrant/confs/ingress.yaml 

echo "=== PODS CREATED ==="
