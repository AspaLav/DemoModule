#!/usr/bin/env nextflow
nextflow.enable.dsl=2

process ALPHA_ANALYSIS {

    input:
    tuple path (params.faith_pd), path (params.metadata_file), path (params.evenness)

    output:
    path 'faith-pd-group-significance.qzv'
    path 'evenness-group-significance.qzv'

    script:
    """
    qiime diversity alpha-group-significance \
  --i-alpha-diversity ${params.faith_pd} \
  --m-metadata-file ${params.metadata_file} \
  --o-visualization faith-pd-group-significance.qzv

 qiime diversity alpha-group-significance \
  --i-alpha-diversity ${params.evenness} \
  --m-metadata-file ${params.metadata_file} \
  --o-visualization evenness-group-significance.qzv

  """
}