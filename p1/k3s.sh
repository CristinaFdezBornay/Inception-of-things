echo Fixing Yum

sed -i 's/mirrorlist/#mirrorlist/g' /etc/yum.repos.d/CentOS-*
sed -i 's|#baseurl=http://mirror.centos.org|baseurl=http://vault.centos.org|g' /etc/yum.repos.d/CentOS-*

echo Yum fixed, installing ifconfig

sudo yum update && sudo yum install net-tools

echo Installing K3s

curl -sfL https://get.k3s.io | sh -

TOKEN_FILE='/var/lib/rancher/k3s/server/node-token'

sudo scp -i /home/vagrant/id_rsa $TOKEN_FILE adricristi@192.168.42.1:~/Inception-of-things/p1/

echo Installatiopn complete
