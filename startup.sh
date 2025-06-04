#!/bin/bash
set -xe

cd /opt || mkdir -p /opt && cd /opt

if [ ! -d "gcp-demo" ]; then
  git clone https://github.com/aniljeenapati/gcp-demo.git
fi

cd gcp-demo

pip3 install --no-cache-dir flask

nohup python3 app.py --host=0.0.0.0 --port=80 &
