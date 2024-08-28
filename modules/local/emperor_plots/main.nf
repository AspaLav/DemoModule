#!/usr/bin/env nextflow
nextflow.enable.dsl=2

process EMPEROR_PLOTS {

    input:
    tuple path (params.unweighted_pcoa), path (params.metadata_file), path (params.bray_pcoa)
    val params.days_of_exp_column

    output:
    path 'unweighted-unifrac-emperor-days-since-experiment-start.qzv'
    path 'bray-curtis-emperor-days-since-experiment-start.qzv'

    script:
    """
    qiime emperor plot \
  --i-pcoa ${params.unweighted_pcoa} \
  --m-metadata-file ${params.metadata_file} \
  --p-custom-axes ${params.days_of_exp_column} \
  --o-visualization unweighted-unifrac-emperor-days-since-experiment-start.qzv

   qiime emperor plot \
  --i-pcoa ${params.bray_pcoa} \
  --m-metadata-file ${params.metadata_file} \
  --p-custom-axes ${params.days_of_exp_column} \
  --o-visualization bray-curtis-emperor-days-since-experiment-start.qzv

  """
}