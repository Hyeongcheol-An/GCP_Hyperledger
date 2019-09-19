docker-compose down
docker rm $(docker ps -q -f status=extied)

