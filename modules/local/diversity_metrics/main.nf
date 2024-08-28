#!/usr/bin/env nextflow
nextflow.enable.dsl=2

process DIVERSITY_METRICS {
  
  input:
  tuple path (params.table_qza), path (params.rooted_tree), path (params.metadata_file)

  output:
  path 'core-metrics-results'

  script:
  """
  qiime diversity core-metrics-phylogenetic \
  --i-phylogeny ${params.rooted_tree} \
  --i-table ${params.table_qza} \
  --p-sampling-depth 1103 \
  --m-metadata-file ${params.metadata_file} \
  --output-dir core-metrics-results

  """
}