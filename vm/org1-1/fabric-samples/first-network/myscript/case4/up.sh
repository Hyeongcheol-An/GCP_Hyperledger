./down.sh
sleep 1
docker-compose -f docker-compose-node.yaml up -d

sleep 3

./ssh_docker_up.sh