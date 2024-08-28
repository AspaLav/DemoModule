#!/usr/bin/env nextflow
nextflow.enable.dsl=2

process BETA_ANALYSIS {

    input:
    tuple path (params.unweighted_distance), path (params.metadata_file)
    val params.bodysite_column
    val params.subject_column

    output:
    path 'unweighted-unifrac-body-site-significance.qzv'
    path 'unweighted-unifrac-subject-group-significance.qzv'

    script:
    """
    qiime diversity beta-group-significance \
  --i-distance-matrix ${params.unweighted_distance} \
  --m-metadata-file ${params.metadata_file} \
  --m-metadata-column ${params.bodysite_column} \
  --o-visualization unweighted-unifrac-body-site-significance.qzv \
  --p-pairwise

   qiime diversity beta-group-significance \
  --i-distance-matrix ${params.unweighted_distance} \
  --m-metadata-file ${params.metadata_file} \
  --m-metadata-column ${params.subject_column} \
  --o-visualization unweighted-unifrac-subject-group-significance.qzv \
  --p-pairwise

  """
}