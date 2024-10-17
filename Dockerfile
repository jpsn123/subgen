FROM nvidia/cuda:12.2.2-cudnn8-runtime-ubuntu22.04

WORKDIR /subgen

COPY requirements.txt /subgen/requirements.txt

RUN apt-get update \
    && apt-get install -y \
        python3 \
        python3-pip \
        ffmpeg \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* \
    && pip3 install -r requirements.txt \
    && pip3 cache purge \
    && rm -rf /root/.cache 

ENV PYTHONUNBUFFERED=1

COPY *.py /subgen/

CMD [ "bash", "-c", "python3 -u launcher.py" ]
