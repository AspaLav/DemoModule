#!/usr/bin/env nextflow
nextflow.enable.dsl=2

process VISUAL_DATA {
    
    container 'qiime2/core:latest'  // Use the appropriate Docker container for QIIME 2

    input:
    path params.demux_qza

    output:
    path "demux.qzv"

    script:
    """
    qiime demux summarize \
    --i-data ${params.demux_qza} \
    --o-visualization demux.qzv

    """
}