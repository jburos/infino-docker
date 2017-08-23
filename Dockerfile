FROM jupyter/datascience-notebook:8f56e3c47fec

COPY conda_requirements.txt /home/jovyan/conda_requirements.txt
COPY pip_requirements.txt /home/jovyan/pip_requirements.txt

RUN conda install --file=/home/jovyan/conda_requirements.txt

RUN pip install -r /home/jovyan/pip_requirements.txt

# set up dependencies
#RUN pyensembl install --release 79 --species homo_sapiens
RUN pip install git+git://github.com/jburos/nbutils
RUN pip install jupyter_contrib_nbextensions
RUN jupyter contrib nbextension install --user

EXPOSE 8888
#CMD ["/bin/bash"]
CMD ["start-notebook.sh", "--NotebookApp.token=''"]