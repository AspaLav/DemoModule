#!/usr/bin/env nextflow
nextflow.enable.dsl=2

process ALPHA_RARE {

    input:
    tuple path (params.table_qza ), path (params.rooted_tree), path (params.metadata_file)

    output:
    path 'alpha-rarefaction.qzv'
    
    script:
    """
    qiime diversity alpha-rarefaction \
  --i-table ${params.table_qza} \
  --i-phylogeny ${params.rooted_tree} \
  --p-max-depth 4000 \
  --m-metadata-file ${params.metadata_file} \
  --o-visualization alpha-rarefaction.qzv

  """
}