FROM jupyter/datascience-notebook:8f56e3c47fec

COPY requirements /home/jovyan/requirements

RUN conda install

RUN pip install