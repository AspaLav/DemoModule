#!/usr/bin/env nextflow
nextflow.enable.dsl=2

process DEMUX_SEQUENCES {
    
    container 'qiime2/core:latest'  // Use the appropriate Docker container for QIIME 2

    input:
    tuple path(params.emp_single_end_sequences), path(params.metadata_file)
    val params.barcode_column

    output:
    path 'demux.qza'
    path 'demux-details.qza'

    script:
    """
    # Demultiplex sequences
    qiime demux emp-single \\
      --i-seqs ${params.emp_single_end_sequences} \\
      --m-barcodes-file ${params.metadata_file} \\
      --m-barcodes-column ${params.barcode_column} \\
      --o-per-sample-sequences demux.qza \\
      --o-error-correction-details demux-details.qza

    """
}
