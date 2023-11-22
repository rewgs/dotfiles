# docker
if [[ $(uname) == "Linux" ]]; then
    alias dcls="docker container ls"
    alias ncst="docker start nextcloud-aio-mastercontainer"
    alias ncsp="docker stop nextcloud-aio-mastercontainer"
    alias rm_all_containers=remove_all_docker_containers
fi
