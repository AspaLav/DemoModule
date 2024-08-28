#!/usr/bin/env nextflow
nextflow.enable.dsl=2

process METADATA_TAB {

container 'qiime2/core:latest'  // Use the appropriate Docker container for QIIME 2

input:
path params.stats_qza

output:
path 'stats-dada2.qzv'

script:
"""
qiime metadata tabulate \
  --m-input-file ${params.stats_qza} \
  --o-visualization stats-dada2.qzv

"""
}