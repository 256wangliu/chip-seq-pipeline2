# Tutorial for Stanford Sherlock cluster


This tutorial shows how to run pipelines on Sherlock.

All test samples and genome data are shared on Stanford Sherlock cluster based on SLURM. You don't have to download any data for testing our pipeline on it.

1. Download [cromwell](https://github.com/broadinstitute/cromwell) on your `$HOME` directory.
    ```bash
    $ cd 
    $ wget https://github.com/broadinstitute/cromwell/releases/download/34/cromwell-34.jar
    $ chmod +rx cromwell-34.jar
    ```

2. SSH to Sherlock's login node.
    ```bash
    $ ssh login.sherlock.stanford.edu
    ```

3. Git clone this pipeline and move into its directory.
    ```bash
    $ cd
    $ git clone https://github.com/ENCODE-DCC/chip-seq-pipeline2
    $ cd chip-seq-pipeline2
    ```

Our pipeline supports both [Conda](https://conda.io/docs/) and [Singularity](https://singularity.lbl.gov/).

## For Conda users

4. [Install Conda](https://conda.io/miniconda.html)

5. Install Conda dependencies.
    ```bash
    $ bash conda/uninstall_dependencies.sh  # to remove any existing pipeline env
    $ bash conda/install_dependencies.sh
    ```

6. Run a pipeline for the test sample. You must have a paid account on Sherlock.
    ```bash
    $ sbatch --partition normal examples/sherlock/ENCSR936XTK_subsampled_sherlock_conda.sh
    ```

## For singularity users

5. Pull a singularity container for the pipeline. This will pull pipeline's docker container first and build a singularity one on `~/.singularity`.
    ```bash
    $ sdev    # Sherlock cluster does not allow building a container on login node
    $ mkdir -p ~/.singularity && cd ~/.singularity && SINGULARITY_CACHEDIR=~/.singularity SINGULARITY_PULLFOLDER=~/.singularity singularity pull --name chip-seq-pipeline-v1.1.5.simg -F docker://quay.io/encode-dcc/chip-seq-pipeline:v1.1.5
    $ exit
    ```

6. Run a pipeline for the test sample. You must have a paid account on Sherlock.
    ```bash
    $ sbatch --partition normal examples/sherlock/ENCSR936XTK_subsampled_sherlock_singularity.sh
    ```

## For all users

7. It will take about an hour. You will be able to find all outputs on `cromwell-executions/chip/[RANDOM_HASH_STRING]/`. See [output directory structure](output.md) for details. You can monitor your jobs with the following command:
    ```bash
    $ squeue -u $USER
    ```

8. See full specification for [input JSON file](input.md).

## For singularity users

9. IF YOU WANT TO RUN PIPELINES WITH YOUR OWN INPUT DATA/GENOME DATABASE, PLEASE ADD THEIR DIRECTORIES TO `workflow_opts/sherlock.json`. For example, you have input FASTQs on `/your/input/fastqs/` and genome database installed on `/your/genome/database/` then add `/your/` to `singularity_bindpath`. You can also define multiple directories there. It's comma-separated.
    ```javascript
    {
        "default_runtime_attributes" : {
            "singularity_container" : "~/.singularity/chip-seq-pipeline-v1.1.5.simg",
            "singularity_bindpath" : "/scratch,/lscratch,/oak/stanford,/home/groups/cherry/encode,/your/,YOUR_OWN_DATA_DIR1,YOUR_OWN_DATA_DIR1,..."
        }
    }
    ```
