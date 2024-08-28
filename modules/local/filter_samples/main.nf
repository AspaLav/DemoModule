#!/usr/bin/env nextflow
nextflow.enable.dsl=2

process FILTER_SAMPLES {

    input:
    tuple path (params.table_qza), path (params.metadata_file)
    val params.bodysite_column

    output:
    path 'gut-table.qza'

    script:
    """
    qiime feature-table filter-samples \
  --i-table ${params.table_qza} \
  --m-metadata-file ${params.metadata_file} \
  --p-where "[${params.bodysite_column}]='gut'" \
  --o-filtered-table gut-table.qza

    """
}