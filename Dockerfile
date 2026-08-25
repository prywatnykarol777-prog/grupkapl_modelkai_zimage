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


# =========================
# Z-IMAGE TURBO
# =========================

RUN mkdir -p \
    /opt/comfyui-baked/models/diffusion_models \
    /opt/comfyui-baked/models/text_encoders \
    /opt/comfyui-baked/models/vae

# Z-Image Turbo BF16
RUN wget -O \
    /opt/comfyui-baked/models/diffusion_models/z_image_turbo_bf16.safetensors \
    "https://huggingface.co/Comfy-Org/z_image_turbo/resolve/main/split_files/diffusion_models/z_image_turbo_bf16.safetensors"

# Qwen 3 4B
RUN wget -O \
    /opt/comfyui-baked/models/text_encoders/qwen_3_4b.safetensors \
    "https://huggingface.co/Comfy-Org/z_image_turbo/resolve/main/split_files/text_encoders/qwen_3_4b.safetensors"

# VAE
RUN wget -O \
    /opt/comfyui-baked/models/vae/ae.safetensors \
    "https://huggingface.co/Comfy-Org/z_image_turbo/resolve/main/split_files/vae/ae.safetensors"

    # =========================
# FACE DETAILER MODELS
# =========================

RUN mkdir -p \
    /opt/comfyui-baked/models/sams \
    /opt/comfyui-baked/models/ultralytics/bbox

# SAM
RUN wget -O \
    /opt/comfyui-baked/models/sams/sam_vit_b_01ec64.pth \
    "https://dl.fbaipublicfiles.com/segment_anything/sam_vit_b_01ec64.pth"

# Face YOLO
RUN wget -O \
    /opt/comfyui-baked/models/ultralytics/bbox/face_yolov8m.pt \
    "https://huggingface.co/Bingsu/adetailer/resolve/main/face_yolov8m.pt"

# =========================
# REALISTIC SNAPSHOT LORA
# =========================

RUN mkdir -p /opt/comfyui-baked/models/loras

RUN wget -O \
    /opt/comfyui-baked/models/loras/RealisticSnapshot-Zimage-Turbov5.safetensors \
    "https://huggingface.co/guillekenzo/realistic-snapshot-zimage/resolve/main/RealisticSnapshot-Zimage-Turbov5.safetensors"

    # =========================
# Z-IMAGE UPSCALER
# =========================

RUN mkdir -p /opt/comfyui-baked/models/upscale_models

RUN wget -O \
    /opt/comfyui-baked/models/upscale_models/zit_upscaler.safetensors \
    "https://huggingface.co/gravedigga/loras/resolve/main/zit_upscaler.safetensors"
