#!/usr/bin/env nextflow
nextflow.enable.dsl=2

process PHYLOGEN_ALIGN {

   container 'qiime2/core:latest'  // Use the appropriate Docker container for QIIME 2

   input:
   path params.rep_seqs_qza

   output:
   path 'aligned-rep-seqs.qza'
   path 'masked-aligned-rep-seqs.qza'
   path 'unrooted-tree.qza'
   path 'rooted-tree.qza'

   script:
   """
   qiime phylogeny align-to-tree-mafft-fasttree \
  --i-sequences ${params.rep_seqs_qza} \
  --o-alignment aligned-rep-seqs.qza \
  --o-masked-alignment masked-aligned-rep-seqs.qza \
  --o-tree unrooted-tree.qza \
  --o-rooted-tree rooted-tree.qza

   """
}