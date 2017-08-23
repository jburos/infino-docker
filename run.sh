#docker run -it --rm --user root -e NB_UID=$(id -u) -e NB_GID=$(id -g) -v $(pwd)/work:/home/jovyan/work -p 58235:8888 jupyter/datascience-notebook start-notebook.sh --NotebookApp.token=''

docker run -it --rm --user root -e NB_UID=$(id -u) -e NB_GID=$(id -g) -v $(pwd)/test:/home/jovyan/work -p 58235:8888 hammerlab/infino_env:latest

#docker run -it --rm -v $(pwd)/test:/home/jovyan/work -p 58235:8888 hammerlab/infino_env:latest