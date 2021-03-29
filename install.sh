#!/usr/bin/env bash

python3.8 -m venv .venv
.venv/bin/pip install click pyyaml
.venv/bin/python manage sync
