#!/usr/bin/env nextflow
nextflow.enable.dsl=2

process FEATURE_SUM {
    
    container 'qiime2/core:latest'  // Use the appropriate Docker container for QIIME 2
    
    input:
    tuple path (params.rep_seqs_qza), path (params.table_qza)

    output:
    path 'rep-seqs.qzv'
    path 'table.qzv'


    script:
    """
    qiime feature-table summarize \
    --i-table ${params.table_qza} \
    --o-visualization table.qzv \
    --m-sample-metadata-file ${params.metadata_file}
    qiime feature-table tabulate-seqs \
    --i-data ${params.rep_seqs_qza} \
    --o-visualization rep-seqs.qzv

   """
}