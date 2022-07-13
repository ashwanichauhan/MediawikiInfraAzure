sudo apt-get update
sudo apt install software-properties-common
sudo add-apt-repository --yes --update ppa:ansible/ansible
sudo apt install ansible
sudo apt install docker.io -y
sleep 1m
sudo systemctl start docker
sudo systemctl enable docker 
OVPN_DATA="ovpn-data-myserver"
docker volume create --name $OVPN_DATA
echo $OVPN_DATA >> /home/volume.txt
PUBLIC_IP="$(dig +short myip.opendns.com @resolver1.opendns.com)"
docker run -v $OVPN_DATA:/etc/openvpn --rm kylemanna/openvpn ovpn_genconfig -u udp://$PUBLIC_IP -p "route 10.0.2.1 255.255.255.0"