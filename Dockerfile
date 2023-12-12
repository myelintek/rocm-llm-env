FROM rocm/pytorch:rocm5.7_ubuntu20.04_py3.9_pytorch_2.0.1 

WORKDIR /root
RUN git clone https://github.com/agrocylo/bitsandbytes-rocm && \
    cd bitsandbytes-rocm && \
    export ROCM_HOME=/opt/rocm/ && \
    make hip -j && \ 
    python3 setup.py install
RUN git clone https://github.com/huggingface/transformers && \
    cd transformers && \
    python3 -m pip install -e . && \
    cd examples/pytorch && \
    python3 -m pip install -r _tests_requirements.txt && \
    cd - && \
    python3 setup.py install

