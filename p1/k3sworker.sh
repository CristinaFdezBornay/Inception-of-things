echo Fixing Yum

sed -i 's/mirrorlist/#mirrorlist/g' /etc/yum.repos.d/CentOS-*
sed -i 's|#baseurl=http://mirror.centos.org|baseurl=http://vault.centos.org|g' /etc/yum.repos.d/CentOS-*

echo Yum fixed, installing ifconfig
sudo systemctl disable firewalld --now

sudo yum update && sudo yum install -y net-tools
echo Installing K3s

SERVER_IP=192.168.42.110

scp -o StrictHostKeyChecking=accept-new -i /home/vagrant/.ssh/id_rsa alagroy-@192.168.42.1:/tmp/node-token . 
curl -sfL https://get.k3s.io | K3S_URL="https://$SERVER_IP:6443" K3S_TOKEN=`sudo cat node-token` sh -s - --flannel-iface=eth1

echo Installation complete
