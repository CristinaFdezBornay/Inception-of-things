CONF_PATH=""

echo ===== INSTALLING DOCKER ======
sudo apt-get remove docker docker-engine docker.io containerd runc
sudo apt-get update
sudo apt-get install -y ca-certificates curl gnupg lsb-release
sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/debian/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/debian $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update
sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-compose-plugin

echo ===== INSTALLING K3D ======
curl -s https://raw.githubusercontent.com/k3d-io/k3d/main/install.sh | bash

echo ===== INSTALLING KUBECTL ======
curl -sfL https://get.k3s.io | sh -


echo ==== CREATING ARGOCD CLUSTER ====
sudo k3d cluster create argocd-cluster --api-port 4242 -p 8080:80@loadbalancer --agents 2

echo ==== INSTALLING ARGOCD ====
sudo kubectl create namespace argocd
sudo kubectl apply -f $CONF_PATH/install.yaml -n argocd
sudo kubectl apply -f $CONF_PATH/ingress.yaml -n argocd

echo ==== SETTING NEW PASSWORD ====
sudo kubectl -n argocd patch secret argocd-secret -p '{"stringData": {"admin.password": "$2a$12$t6bSj.YhcnLX7JYUinhQWOzwwh2e71MNAKamvHZXy48ynEd9hwlPC", "admin.passwordMtime": "'$(date +%FT%T%Z)'"}}'

echo ==== SETTING ARGOCD APPLICATION ====
sudo kubectl create namespace dev
sudo kubectl apply -f $CONF_PATH/project.yaml -n argocd
sudo kubectl apply -f $CONF_PATH/application.yaml -n argocd