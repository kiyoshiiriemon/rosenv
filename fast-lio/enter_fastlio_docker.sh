DOCKER_IMAGE="kiyatdock/fastlio2:latest"
#docker build --network host -t $DOCKER_IMAGE .

gpu="--gpus=all"
if ! command -v nvidia-smi &> /dev/null
then
    echo "NVIDIA Driver not be found"
    gpu=""
fi

docker exec -it fastlio2 /bin/bash
