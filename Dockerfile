FROM runpod/comfyui:cuda12.8

USER root

RUN apt-get update && \
    apt-get install -y git wget curl && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /opt/comfyui-baked/custom_nodes

RUN git clone https://github.com/ltdrdata/ComfyUI-Impact-Pack.git

RUN git clone https://github.com/ltdrdata/ComfyUI-Impact-Subpack.git

RUN git clone https://github.com/ClownsharkBatwing/RES4LYF.git

RUN git clone https://github.com/rgthree/rgthree-comfy.git

RUN pip install --no-cache-dir \
    -r /opt/comfyui-baked/custom_nodes/ComfyUI-Impact-Pack/requirements.txt

RUN pip install --no-cache-dir \
    -r /opt/comfyui-baked/custom_nodes/ComfyUI-Impact-Subpack/requirements.txt

RUN pip install --no-cache-dir \
    -r /opt/comfyui-baked/custom_nodes/RES4LYF/requirements.txt

WORKDIR /opt/comfyui-baked
