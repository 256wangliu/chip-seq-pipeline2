# Dev

## Command line for version change
```bash
PREV_VER=dev-v1.3.2
NEW_VER=dev-v1.3.2
for f in $(grep -rl ${PREV_VER} --include=*.{wdl,md,sh})
do
  sed -i "s/${PREV_VER}/${NEW_VER}/g" ${f}
done
cd dev/workflow_opts
for f in $(grep -rl ${PREV_VER} --include=*.json)
do
  sed -i "s/${PREV_VER}/${NEW_VER}/g" ${f}
done
cd ../../
```

## Building templates on DX for each genome

Make sure that you have [`dxWDL-0.79.1.jar`](https://github.com/DNAnexus/dxWDL/releases/download/0.79.1/dxWDL-0.79.1.jar) on your `$HOME`. Install [DNAnexus Platform SDK](https://wiki.DNAnexus.com/downloads) with `pip install dxpy`. Log-in on DNAnexus with `dx login` and choose "ENCODE Uniform Processing Pipelines" (name of our official DNAnexus project for pipelines).

Run the following command line locally to build out DX workflows for this pipeline on our official one. This will overwrite (`-f` parameter does it).

```bash
# version
VER=dev-v1.3.2
DOCKER=quay.io/encode-dcc/chip-seq-pipeline:$VER

# general
java -jar ~/dxWDL-0.79.1.jar compile chip.wdl -project "ENCODE Uniform Processing Pipelines" -extras <(echo "{\"default_runtime_attributes\":{\"docker\":\"${DOCKER}\"}}") -f -folder /ChIP-seq2/workflows/$VER/general -defaults example_input_json/dx/template_general.json

# hg38
java -jar ~/dxWDL-0.79.1.jar compile chip.wdl -project "ENCODE Uniform Processing Pipelines" -extras <(echo "{\"default_runtime_attributes\":{\"docker\":\"${DOCKER}\"}}") -f -folder /ChIP-seq2/workflows/$VER/hg38 -defaults example_input_json/dx/template_hg38.json

# hg19
java -jar ~/dxWDL-0.79.1.jar compile chip.wdl -project "ENCODE Uniform Processing Pipelines" -extras <(echo "{\"default_runtime_attributes\":{\"docker\":\"${DOCKER}\"}}") -f -folder /ChIP-seq2/workflows/$VER/hg19 -defaults example_input_json/dx/template_hg19.json

# mm10
java -jar ~/dxWDL-0.79.1.jar compile chip.wdl -project "ENCODE Uniform Processing Pipelines" -extras <(echo "{\"default_runtime_attributes\":{\"docker\":\"${DOCKER}\"}}") -f -folder /ChIP-seq2/workflows/$VER/mm10 -defaults example_input_json/dx/template_mm10.json

# mm9
java -jar ~/dxWDL-0.79.1.jar compile chip.wdl -project "ENCODE Uniform Processing Pipelines" -extras <(echo "{\"default_runtime_attributes\":{\"docker\":\"${DOCKER}\"}}") -f -folder /ChIP-seq2/workflows/$VER/mm9 -defaults example_input_json/dx/template_mm9.json

# test sample PE ENCSR936XTK (full)
java -jar ~/dxWDL-0.79.1.jar compile chip.wdl -project "ENCODE Uniform Processing Pipelines" -extras <(echo "{\"default_runtime_attributes\":{\"docker\":\"${DOCKER}\"}}") -f -folder /ChIP-seq2/workflows/$VER/test_ENCSR936XTK -defaults example_input_json/dx/ENCSR936XTK_dx.json

# test sample SE ENCSR000DYI (full)
java -jar ~/dxWDL-0.79.1.jar compile chip.wdl -project "ENCODE Uniform Processing Pipelines" -extras <(echo "{\"default_runtime_attributes\":{\"docker\":\"${DOCKER}\"}}") -f -folder /ChIP-seq2/workflows/$VER/test_ENCSR000DYI -defaults example_input_json/dx/ENCSR000DYI_dx.json

# test sample SE ENCSR000DYI (subsampled, chr19/chrM only)
java -jar ~/dxWDL-0.79.1.jar compile chip.wdl -project "ENCODE Uniform Processing Pipelines" -extras <(echo "{\"default_runtime_attributes\":{\"docker\":\"${DOCKER}\"}}") -f -folder /ChIP-seq2/workflows/$VER/test_ENCSR000DYI_subsampled_chr19_only -defaults example_input_json/dx/ENCSR000DYI_subsampled_chr19_only_dx.json

# test sample SE ENCSR000DYI (subsampled, chr19/chrM only, rep1)
java -jar ~/dxWDL-0.79.1.jar compile chip.wdl -project "ENCODE Uniform Processing Pipelines" -extras <(echo "{\"default_runtime_attributes\":{\"docker\":\"${DOCKER}\"}}") -f -folder /ChIP-seq2/workflows/$VER/test_ENCSR000DYI_subsampled_chr19_only_rep1 -defaults example_input_json/dx/ENCSR000DYI_subsampled_chr19_only_rep1_dx.json

## DX Azure

# general
java -jar ~/dxWDL-0.79.1.jar compile chip.wdl -project "ENCODE Uniform Processing Pipelines Azure" -extras <(echo "{\"default_runtime_attributes\":{\"docker\":\"${DOCKER}\"}}") -f -folder /ChIP-seq2/workflows/$VER/general -defaults example_input_json/dx_azure/template_general.json

# hg38
java -jar ~/dxWDL-0.79.1.jar compile chip.wdl -project "ENCODE Uniform Processing Pipelines Azure" -extras <(echo "{\"default_runtime_attributes\":{\"docker\":\"${DOCKER}\"}}") -f -folder /ChIP-seq2/workflows/$VER/hg38 -defaults example_input_json/dx_azure/template_hg38.json

# hg19
java -jar ~/dxWDL-0.79.1.jar compile chip.wdl -project "ENCODE Uniform Processing Pipelines Azure" -extras <(echo "{\"default_runtime_attributes\":{\"docker\":\"${DOCKER}\"}}") -f -folder /ChIP-seq2/workflows/$VER/hg19 -defaults example_input_json/dx_azure/template_hg19.json

# mm10
java -jar ~/dxWDL-0.79.1.jar compile chip.wdl -project "ENCODE Uniform Processing Pipelines Azure" -extras <(echo "{\"default_runtime_attributes\":{\"docker\":\"${DOCKER}\"}}") -f -folder /ChIP-seq2/workflows/$VER/mm10 -defaults example_input_json/dx_azure/template_mm10.json

# mm9
java -jar ~/dxWDL-0.79.1.jar compile chip.wdl -project "ENCODE Uniform Processing Pipelines Azure" -extras <(echo "{\"default_runtime_attributes\":{\"docker\":\"${DOCKER}\"}}") -f -folder /ChIP-seq2/workflows/$VER/mm9 -defaults example_input_json/dx_azure/template_mm9.json

# test sample PE ENCSR936XTK (full)
java -jar ~/dxWDL-0.79.1.jar compile chip.wdl -project "ENCODE Uniform Processing Pipelines Azure" -extras <(echo "{\"default_runtime_attributes\":{\"docker\":\"${DOCKER}\"}}") -f -folder /ChIP-seq2/workflows/$VER/test_ENCSR936XTK -defaults example_input_json/dx_azure/ENCSR936XTK_dx_azure.json

# test sample SE ENCSR000DYI (full)
java -jar ~/dxWDL-0.79.1.jar compile chip.wdl -project "ENCODE Uniform Processing Pipelines Azure" -extras <(echo "{\"default_runtime_attributes\":{\"docker\":\"${DOCKER}\"}}") -f -folder /ChIP-seq2/workflows/$VER/test_ENCSR000DYI -defaults example_input_json/dx_azure/ENCSR000DYI_dx_azure.json

# test sample SE ENCSR000DYI (subsampled, chr19/chrM only)
java -jar ~/dxWDL-0.79.1.jar compile chip.wdl -project "ENCODE Uniform Processing Pipelines Azure" -extras <(echo "{\"default_runtime_attributes\":{\"docker\":\"${DOCKER}\"}}") -f -folder /ChIP-seq2/workflows/$VER/test_ENCSR000DYI_subsampled_chr19_only -defaults example_input_json/dx_azure/ENCSR000DYI_subsampled_chr19_only_dx_azure.json
```
