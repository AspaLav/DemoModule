#!/usr/bin/env nextflow
nextflow.enable.dsl=2

process COMPOSITION_DATA {

    input:
    tuple path(params.gut_table), path(params.metadata_file)
    val params.subject_column

    output:
    path 'ancombc-subject.qza'

    script:
    """
    qiime composition ancombc \
  --i-table ${params.gut_table} \
  --m-metadata-file ${params.metadata_file} \
  --p-formula ${params.subject_column} \
  --o-differentials ancombc-subject.qza

  """
}