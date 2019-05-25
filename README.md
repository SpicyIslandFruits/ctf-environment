# ctf-environment
docker-compose build && xhost +local: && docker run --privileged --name ctf -it -e DISPLAY=$DISPLAY -v /tmp/.X11-unix/:/tmp/.X11-unix/ ctf_environment
