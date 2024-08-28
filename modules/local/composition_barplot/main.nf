#!/usr/bin/env nextflow
nextflow.enable.dsl=2

process COMPOSITION_BARPLOT {

    input:
    path params.ancombc

    output:
    path 'l6-da-barplot-subject.qzv'

    script:
    """
    qiime composition da-barplot \
  --i-data ${params.ancombc} \
  --p-significance-threshold 0.001 \
  --p-level-delimiter ';' \
  --o-visualization l6-da-barplot-subject.qzv

   """
}