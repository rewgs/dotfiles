# docker
if [[ $(uname) == "Linux" ]]; then
    if [[ $(whoami) != "root" ]]; then
        alias docker="sudo docker"
    fi
    alias dls="docker container ls"
    alias drmac=remove_all_docker_containers
fi
