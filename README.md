This is a development environment for infino.

# Install

1. Clone the code into your home directory: `git clone git@github.com:hammerlab/immune-infiltrate-explorations.git`
2. Set up a shared model cache that is world-readable: `sudo mkdir -p /data/modelcache_new && sudo chmod -R 777 /data/modelcache_new`
3. Pull docker image: `docker pull hammerlab/infino-docker:latest`

# Use

1. Run: `docker run -d --name [name your container here] -v $HOME/immune-infiltrate-explorations:/home/jovyan/work -v /data/modelcache_new:/modelcache -v /data/output_unpackaged:/data:ro -v /data/microarray:/microarrays:ro -v /data/cibersort:/cibersort:ro -p [put port that you have forwarded here]:8888 --user root -e NB_UID=$(id -u) -e NB_GID=$(id -g) hammerlab/infino-docker:latest`
2. After around two minutes (initial startup), navigate to that port that you have set up to forward -- you will see a jupyter notebook server.
3. To commit code, use `git` from the host (as opposed to from inside the docker container).

This command mounts your personal code directory, the shared model cache, the shared RNA-seq and microarray data directories, and the global Cibersort install, and acts as your user account for all editing purposes. (Note: anything mounted into `/home/jovyan` will have its ownership changed, which isn't possible in some situations, e.g. if readonly file system.)

# More options available

You can view logs with: `docker logs [name of your container here]`.

You can get a shell into the container in the following ways:

* `docker run -it --name [name your container here] -v $HOME/immune-infiltrate-explorations:/home/jovyan/work -v /data/modelcache_new:/home/jovyan/modelcache -p [put port that you have forwarded here]:8888 --user root -e NB_UID=$(id -u) -e NB_GID=$(id -g) hammerlab/infino-docker:latest bash` (if you are starting a new container)
* `docker exec -it [name your container here] bash` (shell into an existing container)

Teardown:

```
docker stop [name of your container here] # restart with "docker start"
docker rm [name of your container here]
```

Mounted directories will be unaffected because they live on the host.


# How the image works

This is derived from the Jupyter "data science notebook" image:

* [Docker hub page](https://hub.docker.com/r/jupyter/datascience-notebook/)
* [Dockerfile](https://github.com/jupyter/docker-stacks/blob/master/datascience-notebook/Dockerfile)

You can use any options from that image, e.g. you can grant sudo access by adding `-e GRANT_SUDO=yes`.

Our image installs pip and conda requirements from the primary repository into a python3 environment. Here is how to get those if you want to update the image:

```
wget https://raw.githubusercontent.com/hammerlab/immune-infiltrate-explorations/master/model-single-origin-samples/biokepi/conda_requirements.txt
wget https://raw.githubusercontent.com/hammerlab/immune-infiltrate-explorations/master/model-single-origin-samples/biokepi/pip_requirements.txt
```

To build: `docker build -t hammerlab/infino-docker:latest .`

