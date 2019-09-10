docker rm $(docker ps -q -f status=exited)

docker rm -f $(docker ps -aq)

docker volume prune
docker network prune

docker-compose -f docker-compose-node.yaml up -d

