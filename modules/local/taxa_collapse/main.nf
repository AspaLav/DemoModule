#!/usr/bin/env nextflow
nextflow.enable.dsl=2

process TAXA_COLLAPSE {

    input:
    tuple path(params.gut_table), path(params.taxonomy_qza), path(params.metadata_file)
    val params.subject_column

    output:
    path 'gut-table-l6.qza'
    path 'l6-ancombc-subject.qza'

    script:
    """
    qiime taxa collapse \
  --i-table ${params.gut_table}\
  --i-taxonomy ${params.taxonomy_qza} \
  --p-level 6 \
  --o-collapsed-table gut-table-l6.qza

  qiime composition ancombc \
  --i-table ${params.gut_table} \
  --m-metadata-file ${params.metadata_file} \
  --p-formula ${params.subject_column} \
  --o-differentials l6-ancombc-subject.qza

  """
}