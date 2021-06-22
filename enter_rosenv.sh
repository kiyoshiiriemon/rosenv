DOCKER_IMAGE="kiyatdock/rosenv:melodic"
docker build --network host -t $DOCKER_IMAGE .

gpu="--gpus=all"
if ! command -v nvidia-smi &> /dev/null
then
    echo "NVIDIA Driver not be found"
    gpu=""
fi

xhost +
docker run $gpu -it --rm --cap-add=SYS_PTRACE --security-opt seccomp=unconfined \
    --name rosenv \
    -e DISPLAY -v /tmp/.X11-unix:/tmp/.X11-unix:rw \
    -u `id -u`:`id -g` \
    --net host \
    -v ~/catkin_ws:/home/rosuser/catkin_ws:rw \
    $DOCKER_IMAGE /bin/bash
