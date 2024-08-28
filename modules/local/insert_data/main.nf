process IMPORT_DATA {
    container 'qiime2/core:latest'  // Use the appropriate Docker container for QIIME 2

    input:
    path params.folder1

    output:
    path "emp-single-end-sequences.qza"

    script:
    """
    # Print the current working directory and list files
    pwd
    ls -l ${params.folder1}

    # Print the absolute path of the input directory
    echo "Input path: ${params.folder1}"

    qiime tools import \
      --type EMPSingleEndSequences \
      --input-path ${params.folder1} \
      --output-path emp-single-end-sequences.qza \
    """
}
