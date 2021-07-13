#!/usr/bin/env bash

cd $(dirname $0)
python3 -m venv .venv
.venv/bin/pip install click pyyaml
.venv/bin/python manage sync
