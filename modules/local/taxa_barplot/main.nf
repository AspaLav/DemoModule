#!/usr/bin/env nextflow
nextflow.enable.dsl=2

process TAXA_BARPLOT {

    input:
    tuple path (params.table_qza), path (params.taxonomy_qza), path (params.metadata_file)

    output:
    path 'taxa-bar-plots.qzv'

    script:
    """
    qiime taxa barplot \
  --i-table ${params.table_qza} \
  --i-taxonomy ${params.taxonomy_qza} \
  --m-metadata-file ${params.metadata_file} \
  --o-visualization taxa-bar-plots.qzv

  """
}