#!/bin/bash
# Stop on error
set -e

CONDA_ENV=encode-chip-seq-pipeline
CONDA_ENV_PY3=encode-chip-seq-pipeline-python3

SH_SCRIPT_DIR=$(cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd)

REQ_TXT=${SH_SCRIPT_DIR}/requirements.txt
REQ_TXT_PY3=${SH_SCRIPT_DIR}/requirements_py3.txt

if which conda; then
  echo "=== Found Conda ($(conda --version))."
else
  echo "=== Conda does not exist on your system. Please install Conda first."
  echo "https://conda.io/docs/user-guide/install/index.html#regular-installation"
  exit 1
fi

echo "=== All done."
