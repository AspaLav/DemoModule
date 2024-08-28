#!/usr/bin/env nextflow
nextflow.enable.dsl=2

process CLASS_SKL2 {

    input:
    path params.taxonomy_qza

    output:
    path 'taxonomy.qzv'

    script:
    """
    qiime metadata tabulate \
   --m-input-file ${params.taxonomy_qza} \
   --o-visualization taxonomy.qzv
 
    """
}