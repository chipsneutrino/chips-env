FROM continuumio/miniconda3:4.7.12-alpine
LABEL name=chips-conda

COPY env.yml /opt

# Install chips-conda environment
RUN echo ". /opt/conda/etc/profile.d/conda.sh" >> ~/.bashrc && \
    echo "source activate $(head -1 /opt/env.yml | cut -d' ' -f2)" > ~/.bashrc && \
    /opt/conda/bin/conda env create -f /opt/env.yml && \
    /opt/conda/bin/conda clean -afy
    