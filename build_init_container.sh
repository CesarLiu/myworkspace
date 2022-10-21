
# MY_WS_ROOT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )/../.." && pwd -P )"
# if [ "$(readlink -f /myworkspace)" != "${MY_WS_ROOT_DIR}" ]; then
#     ln -snf ${MY_WS_ROOT_DIR} /myworkspace
# fi

docker build . -t st_docker/cuda-torch-cv:cuda114-py38-torch11-cv
# prepare gpu support and increase share memory for dataloader
DEV_CONTAINER="st_docker_${USER}"
SHM_SIZE="50G"
docker run -d --gpus all -it --name "${DEV_CONTAINER}" --shm-size "${SHM_SIZE}" -w /myworkspace -v $(pwd):/myworkspace st_docker/cuda-torch-cv:cuda114-py38-torch11-cv
