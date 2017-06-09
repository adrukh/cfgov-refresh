#/bin/bash

# if docker ps succeeds, docker environment is already sane and
# we don't need to mess with docker-machine
docker ps 2>/dev/null
if [ $? -eq 0 ]; then
  DOCKER_SANE=1
else
   MACHINE_IP=$(docker-machine ip cfgov)

    # like above--if the "cfgov" machine doesn't exist, create it
    if [ -z "$MACHINE_IP" ]; then
        docker-machine ls | grep cfgov
        if [ $? -gt 0 ]; then
            docker-machine create cfgov > /dev/null
            vboxmanage controlvm cfgov natpf1 "mysql,tcp,,3306,,3306"
            vboxmanage controlvm cfgov natpf1 "pdfreactor,tcp,,9423,,9423"
            vboxmanage controlvm cfgov natpf1 "es1,tcp,,9200,,9200"
            vboxmanage controlvm cfgov natpf1 "es2,tcp,,9300,,9300"
        fi
    fi

    docker-machine start cfgov
    eval $(docker-machine env cfgov)
fi

docker-compose up -d
#$MACHINE_IP
