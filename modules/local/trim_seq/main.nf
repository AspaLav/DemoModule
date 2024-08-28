#!/usr/bin/env nextflow
nextflow.enable.dsl=2

process TRIM_DATA {

 container 'qiime2/core:latest'  // Use the appropriate Docker container for QIIME 2

 input:
 path params.demux_qza

 output:
 path 'rep-seqs.qza' 
 path 'table.qza' 
 path 'stats.qza'

 script:
 """
 qiime dada2 denoise-single \
  --i-demultiplexed-seqs ${params.demux_qza} \
  --p-trim-left 0 \
  --p-trunc-len 120 \
  --o-representative-sequences rep-seqs.qza \
  --o-table table.qza \
  --o-denoising-stats stats.qza

  """
}
