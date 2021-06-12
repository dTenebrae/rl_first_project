FROM python:3.7.10

RUN DEBIAN_FRONTEND=noninteractive apt-get update \
    && apt-get install -y --no-install-recommends \
       apt-utils \
       build-essential \
       curl \
       xvfb \
       ffmpeg \
       xorg-dev \
       libsdl2-dev \
       swig \
       cmake \
       python-opengl

RUN pip3 install --upgrade pip

COPY requirements.txt /tmp/

COPY test/test_image.py /tmp/

RUN pip3 install --trusted-host pypi.python.org -r /tmp/requirements.txt

RUN rm /tmp/requirements.txt

RUN mkdir /home/my_rl

WORKDIR /home/my_rl

ADD scripts/startup_script.sh /usr/local/bin/startup_script.sh

#Give execution permissions
RUN chmod 777 /usr/local/bin/startup_script.sh

ENTRYPOINT ["/usr/local/bin/startup_script.sh"]
