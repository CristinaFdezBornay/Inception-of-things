echo Fixing Yum

sed -i 's/mirrorlist/#mirrorlist/g' /etc/yum.repos.d/CentOS-*
sed -i 's|#baseurl=http://mirror.centos.org|baseurl=http://vault.centos.org|g' /etc/yum.repos.d/CentOS-*

echo Yum fixed, installing ifconfig
sudo systemctl disable firewalld --now

sudo yum update && sudo yum install -y net-tools

echo Installing K3s

curl -sfL https://get.k3s.io | sh -s - server --flannel-iface=eth1 --disable traefik --disable servicelb

TOKEN_FILE='/var/lib/rancher/k3s/server/node-token'

sudo scp -o StrictHostKeyChecking=accept-new -i /home/vagrant/.ssh/id_rsa $TOKEN_FILE alagroy-@192.168.42.1:/tmp/node-token

echo Installation complete
