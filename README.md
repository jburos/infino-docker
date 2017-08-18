pip_requirements.txt, conda_requirements.txt from biokepi folder


conda env with python3


start on host:
`git clone git@github.com:hammerlab/immune-infiltrate-explorations.git`
mount that in.

```
export PATH="/home/maxim/miniconda3/bin:$PATH"

conda create -n immuneinf python=3.5 matplotlib pandas seaborn numpy scipy jupyter
# jacki says:
# conda create -n immuneinf python=3 matplotlib pandas seaborn numpy scipy jupyter


source activate immuneinf 

# install dependencies

#wget https://raw.githubusercontent.com/hammerlab/immune-infiltrate-explorations/biokepi/model-single-origin-samples/biokepi/conda_requirements.txt
https://raw.githubusercontent.com/hammerlab/immune-infiltrate-explorations/biokepi-update/model-single-origin-samples/biokepi/conda_requirements.txt
# wget https://raw.githubusercontent.com/hammerlab/immune-infiltrate-explorations/biokepi/model-single-origin-samples/biokepi/pip_requirements.txt
wget https://raw.githubusercontent.com/hammerlab/immune-infiltrate-explorations/biokepi-update/model-single-origin-samples/biokepi/pip_requirements.txt

conda install --file=conda_requirements.txt
pip install -r pip_requirements.txt

# set up dependencies
pyensembl install --release 79 --species homo_sapiens

# add kernel to jupyter nb
python -m ipykernel install --user --name=immune3

# install nbexecute binary
pip install git+git://github.com/jburos/nbutils
# now can run:
# nbexecute --kernel-name=immune3 --timeout 900000 0.85*.ipynb

# install jupyter nb extensions
pip install jupyter_contrib_nbextensions
jupyter contrib nbextension install --user



# run 
source activate immuneinf
jupyter notebook --no-browser --NotebookApp.token=''

```


also mount /data/output/* to model-single-origin-source/data/ on host.

modify cachedir in cache.py on host.


install git config from host? or where will be committing to git from? probably from the host. so maybe don't do this.

TODO: make pyensembl a base image. actually that's tough because have special kernel. maybe pyensembl has a way to avoid the data download.


NOTEBOOK_ARGS

pip install some-package
conda install some-package

docker run -it --rm -e GRANT_SUDO=yes -v /tmp/mycode:/home/jovyan/work -p 8888:8888 jupyter/datascience-notebook start-notebook.sh --NotebookApp.token=''

docker run -it --rm --user root -e NB_UID=$(id -u) -e NB_GID=$(id -g) -v $(pwd)/work:/home/jovyan/work -p 58235:8888 jupyter/datascience-notebook start-notebook.sh --NotebookApp.token=''





docker run -it --rm --user root -e NB_UID=$(id -u) -e NB_GID=$(id -g) -v $(pwd)/work:/home/jovyan/work -p 58235:8888 jupyter/datascience-notebook start-notebook.sh --NotebookApp.token=''


# infino-env
