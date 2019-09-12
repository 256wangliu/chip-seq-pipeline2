# How to install pipeline's Conda environment

1) Install [Conda](https://docs.conda.io/en/latest/miniconda.html).

2) Install Conda environment for pipeline.

  ```bash
  $ conda/install_dependencies.sh
  ```

3) Initialize Conda and re-login. Skip this step for Conda < 4.6.

  ```bash
  $ conda init bash  # for Conda >= 4.6
  $ exit
  ```

4) Configure pipeline's python2 and python3 environments.

  ```bash
  $ # source activate encode-chip-seq-pipeline  # for Conda < 4.6
  $ conda activate encode-chip-seq-pipeline  # for Conda >= 4.6
  $ conda/config_conda_env.sh
  ```

5) Update pipeline's Conda environment with pipeline's python source code. You need to run this step everytime you update (`git pull`) this pipeline.

  ```bash
  $ # source activate encode-chip-seq-pipeline  # for Conda < 4.6
  $ conda activate encode-chip-seq-pipeline  # for Conda >= 4.6
  $ conda/update_conda_env.sh
  ```
