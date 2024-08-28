#!/usr/bin/env nextflow
nextflow.enable.dsl=2

process CLASS_SKL {

    input:
    tuple path (params.classifier), path (params.rep_seqs_qza)

    output:
    path 'taxonomy.qza'

    script:
    """
    qiime feature-classifier classify-sklearn \
  --i-classifier ${params.classifier} \
  --i-reads ${params.rep_seqs_qza} \
  --o-classification taxonomy.qza

  """

}