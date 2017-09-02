FROM jupyter/datascience-notebook:8f56e3c47fec

COPY conda_requirements.txt /home/jovyan/conda_requirements.txt
COPY pip_requirements.txt /home/jovyan/pip_requirements.txt
COPY install_Cibersort_dependencies.R /home/jovyan/install_Cibersort_dependencies.R
COPY runRserve.R /home/jovyan/runRserve.R

RUN conda install --file=/home/jovyan/conda_requirements.txt

RUN pip install -r /home/jovyan/pip_requirements.txt

# set up jdk (to run cibersort)
RUN apt-get update -y
RUN apt-get install -y openjdk-8-jdk
ENV JAVA_HOME='/usr/lib/jvm/java-8-openjdk-amd64'
RUN javac -version # validates that installed

# set up R dependencies for Cibersort
ENV LD_LIBRARY_PATH="/opt/conda/lib/R/lib:/opt/conda/lib:${LD_LIBRARY_PATH}"
RUN Rscript /home/jovyan/install_Cibersort_dependencies.R
# Rserve need to install from source to run from command line
# RUN wget -P /home/jovyan/ https://cran.r-project.org/src/contrib/Rserve_1.7-3.tar.gz
# RUN R CMD INSTALL /home/jovyan/Rserve_1.7-3.tar.gz

# set up dependencies
RUN pyensembl install --release 79 --species homo_sapiens
RUN pip install git+git://github.com/jburos/nbutils
RUN pip install jupyter_contrib_nbextensions
RUN jupyter contrib nbextension install --user

# below needed to fix cython behavior (for stan especially)
# can test behavior with: python -c 'import sklearn.linear_model.tests.test_randomized_l1'
# (https://github.com/BVLC/caffe/issues/3884)
RUN conda install mkl

EXPOSE 8888
#CMD ["/bin/bash"]
# CMD ["start-notebook.sh", "--NotebookApp.token=''"]
# start Rserv in daemon mode for Cibersort
CMD Rscript /home/jovyan/runRserve.R && start-notebook.sh --NotebookApp.token=''