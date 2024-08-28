#!/usr/bin/env nextflow
nextflow.enable.dsl=2

process COMPOSITION_DATA2 {

    input:
    path params.ancombc

    output:
    path 'da-barplot-subject.qzv'

    script:
    """
    qiime composition da-barplot \
  --i-data ${params.ancombc} \
  --p-significance-threshold 0.001 \
  --o-visualization da-barplot-subject.qzv

   """
}