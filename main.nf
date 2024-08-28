#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

/*
 * pipeline input parameters
 */
params.projectDir = "/mnt/c/Users/ASPA-PC/Desktop/aspa-project"
params.folder1 = "${params.projectDir}/qiime2-moving-pictures-tutorial/emp-single-end-sequences"
params.emp_single_end_sequences = "${params.projectDir}/test_results/import/emp-single-end-sequences.qza"
params.metadata_file = "${params.projectDir}/qiime2-moving-pictures-tutorial/sample-metadata.tsv"
params.barcode_column = "barcode-sequence"
params.demux_qza = "${params.projectDir}/test_results/demux/demux.qza"
params.stats_qza = "${params.projectDir}/test_results/trim/stats.qza"
params.rep_seqs_qza = "${params.projectDir}/test_results/trim/rep-seqs.qza"
params.table_qza = "${params.projectDir}/test_results/trim/table.qza"
params.rooted_tree = "${params.projectDir}/test_results/phylogen/rooted-tree.qza"
params.faith_pd = "${params.projectDir}/test_results/diversity/core-metrics-results/faith_pd_vector.qza"
params.evenness = "${params.projectDir}/test_results/diversity/core-metrics-results/evenness_vector.qza"
params.unweighted_distance = "${params.projectDir}/test_results/diversity/core-metrics-results/unweighted_unifrac_distance_matrix.qza"
params.bodysite_column = "body-site"
params.subject_column ="subject"
params.unweighted_pcoa = "${params.projectDir}/test_results/diversity/core-metrics-results/unweighted_unifrac_pcoa_results.qza"
params.days_of_exp_column = "days-since-experiment-start"
params.bray_pcoa = "${params.projectDir}/test_results/diversity/core-metrics-results/bray_curtis_pcoa_results.qza"
params.classifier = "${params.projectDir}/qiime2-moving-pictures-tutorial/gg-13-8-99-515-806-nb-classifier.qza"
params.taxonomy_qza = "${params.projectDir}/test_results/class/taxonomy.qza"
params.gut_table = "${params.projectDir}/test_results/filter/gut-table.qza"
params.ancombc = "${params.projectDir}/test_results/taxa/l6-ancombc-subject.qza"

/*
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    IMPORT FUNCTIONS / MODULES / SUBWORKFLOWS / WORKFLOWS
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
*/

include { IMPORT_DATA }                             from './modules/local/insert_data/main.nf'
//include { DEMUX_SEQUENCES }                         from './modules/local/demultiplexing_seq/main.nf'
//include { VISUAL_DATA }                             from './modules/local/visual_data/main.nf'
//include { TRIM_DATA }                               from './modules/local/trim_seq/main.nf'
//include { METADATA_TAB }                            from './modules/local/metadata_tab/main.nf'
//include { FEATURE_SUM }                             from './modules/local/feature_sum/main.nf'
//include { PHYLOGEN_ALIGN }                          from './modules/local/phylogen_tree/main.nf'
//include { DIVERSITY_METRICS }                       from './modules/local/diversity_metrics/main.nf'
//include { ALPHA_ANALYSIS }                          from './modules/local/alpha_analysis/main.nf'
//include { BETA_ANALYSIS }                           from './modules/local/beta_analysis/main.nf'
//include { EMPEROR_PLOTS }                           from './modules/local/emperor_plots/main.nf' 
//include { ALPHA_RARE }                              from './modules/local/alpha_rarefacation/main.nf'
//include { CLASS_SKL }                               from './modules/local/classifier_skl/main.nf'
//include { CLASS_SKL2 }                              from './modules/local/classifier_skl2/main.nf'
//include { TAXA_BARPLOT }                            from './modules/local/taxa_barplot/main.nf'
//include { FILTER_SAMPLES }                          from './modules/local/filter_samples/main.nf'
//include { COMPOSITION_DATA }                          from './modules/local/composition_data/main.nf'
//include { COMPOSITION_DATA2 }                           from './modules/local/composition_data2/main.nf'
include { TAXA_COLLAPSE }                               from './modules/local/taxa_collapse/main.nf'
include { COMPOSITION_BARPLOT }                         from './modules/local/composition_barplot/main.nf'
/*
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    RUN MAIN WORKFLOW
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
*/

log.info """
    Q I I M E 2   I M P O R T   P I P E L I N E
    ============================================
    Input folder: ${params.folder1}
    """
    .stripIndent()


workflow {

    main:

    // Create a channel for the input folder
    input_folder_ch = Channel.fromPath(params.folder1, checkIfExists: true)

    // Run the IMPORT_DATA process
    import_data_out = IMPORT_DATA(input_folder_ch)
    
    // View the output path to confirm
    import_data_out.view()
     
    // Define the input channel to extract only the barcode-sequence column
    //barcode_value_channel = Channel
    //.fromPath(params.metadata_file)
    //.splitCsv(header: true, sep: '\t')  // Ensure the correct delimiter is used
    //.map { row -> row[params.barcode_column] }  // Extract only the barcode-sequence column


    // Run the demux_results process
    // demux_results = DEMUX_SEQUENCES(
    //tuple(params.emp_single_end_sequences, params.metadata_file),
    //barcode_value_channel
   // )

    // Split the outputs and view them individually
    //demux_results[0].view()  // View demux.qza
    //demux_results[1].view()  // View demux-details.qza

    // Create a channel for the input visualising
   // input_visual_ch = Channel.fromPath(params.demux_qza, checkIfExists: true)

    // Run the VISUAL_DATA process
   // visual_data_out = VISUAL_DATA(input_visual_ch)
    
    // View the output path to confirm
   // visual_data_out.view()

   // Run the TRIM_DATA process
   //trim_data_out = TRIM_DATA(input_visual_ch)

   // Split the outputs and view them individually
    // trim_data_out[0].view()  // View rep-seqs-dada2.qza
    // trim_data_out[1].view()  // View table-dada2.qza
    // trim_data_out[2].view()  // View stats-dada2.qza

  // Create a channel for the input metadata
   // input_metadata_ch = Channel.fromPath(params.stats_qza, checkIfExists: true)

  // Run the METADATA_TAB process
   // metadata_out = METADATA_TAB(input_metadata_ch)

  // View the output path to confirm
   // metadata_out.view()

  //Create a channel for the feauture input files
  // input_feature_ch = Channel.fromPath(params.rep_seqs_qza, checkIfExists: true)
                            // .combine(Channel.fromPath(params.table_qza, checkIfExists: true))
                            // .map { rep_seqs, table2 -> tuple(rep_seqs, table2) }

 // Run the FEATURE_SUM process
  // feature_out = FEATURE_SUM(input_feature_ch)

 // Split the outputs and view them individually
   // feature_out[0].view()  // View rep-seqs.qzv
   // feature_out[1].view()  // View table.qzv

 // Create a channel for the input phylogen_tree
   // input_phylogen_ch = Channel.fromPath(params.rep_seqs_qza, checkIfExists: true)

 // Run the PHYLOGEN_ALIGN process
   // phylogen_out = PHYLOGEN_ALIGN(input_phylogen_ch)

 // Split the outputs and view them individually
  //  phylogen_out[0].view()  // View aligned-rep-seqs.qza
  //  phylogen_out[1].view()  // View masked-aligned-rep-seqs.qza
   // phylogen_out[2].view()  // View unrooted-tree.qza
   // phylogen_out[3].view()  // View rooted-tree.qza

//Create a channel for the diversity input files
  // input_diversity_ch = Channel.fromPath(params.table_qza, checkIfExists: true)
                              // .combine(Channel.fromPath(params.rooted_tree, checkIfExists: true))
                              // .combine(Channel.fromPath(params.metadata_file, checkIfExists: true))
                              // .map { table_qza, rooted_tree, metadata_file -> tuple(table_qza, rooted_tree, metadata_file) }

// Run the  DIVERSITY_METRICS process
   // diversity_out =  DIVERSITY_METRICS(input_diversity_ch)

// View the output path to confirm
   // diversity_out.view()
 
//Create a channel for the alpha input files
  // input_alpha_ch = Channel.fromPath(params.faith_pd, checkIfExists: true)
                            // .combine(Channel.fromPath(params.metadata_file, checkIfExists: true))
                            // .combine(Channel.fromPath(params.evenness, checkIfExists: true))
                            // .map { faith_pd, evenness, metadata_file -> tuple(faith_pd, evenness, metadata_file) }

// Run the  ALPHA_ANALYSIS process
   // alpha_out =  ALPHA_ANALYSIS(input_alpha_ch)

 // Split the outputs and view them individually
   // alpha_out[0].view()  // View faith-pd-group-significance.qzv
    //alpha_out[1].view()  // View evenness-group-significance.qzv

 // Define the input channel to extract only the body-site column
     beta_value_channel = Channel
    .fromPath(params.metadata_file)
    .splitCsv(header: true, sep: '\t')  // Ensure the correct delimiter is used
    .map { row -> row[params.bodysite_column] }  // Extract only the body-site column

 // Define the input channel to extract only the subject column
     beta_value2_channel = Channel
    .fromPath(params.metadata_file)
    .splitCsv(header: true, sep: '\t')  // Ensure the correct delimiter is used
    .map { row -> row[params.subject_column] }  // Extract only the subject column


    // Run the BETA_ANALYSIS process
    // beta_results = BETA_ANALYSIS(
    //tuple(params.unweighted_distance, params.metadata_file),
   // beta_value_channel, beta_value2_channel
   // )

    // Split the outputs and view them individually
    //beta_results[0].view()  // View unweighted-unifrac-body-site-significance.qzv
    //beta_results[1].view()  // View unweighted-unifrac-subject-group-significance.qzv

 // Define the input channel to extract only the days-since-experiment-start column
   // emperor_value_channel = Channel
   //.fromPath(params.metadata_file)
    //.splitCsv(header: true, sep: '\t')  // Ensure the correct delimiter is used
    //.map { row -> row[params.days_of_exp_column] }  // Extract only the days-since-experiment-start column


    // Run the EMPEROR_PLOTS process
    // emperor_results = EMPEROR_PLOTS(
    //tuple(params.unweighted_pcoa, params.metadata_file, params.bray_pcoa),
   // emperor_value_channel)

    // Split the outputs and view them individually
   // emperor_results[0].view()  // View unweighted-unifrac-emperor-days-since-experiment-start.qzv
    //emperor_results[1].view()  // View bray-curtis-emperor-days-since-experiment-start.qzv

    // Run the  ALPHA_RARE process
    // alpha_rare_out =  ALPHA_RARE(input_diversity_ch)

    //View the output path to confirm
    // alpha_rare_out.view()

    //Create a channel for the classifier_skl input files
   // input_classifier_ch = Channel.fromPath(params.classifier, checkIfExists: true)
                             //  .combine(Channel.fromPath(params.rep_seqs_qza, checkIfExists: true))
                              // .map {classifier, rep_seqs_qza -> tuple(classifier, rep_seqs_qza)}
    
    // Run the CLASS_SKL process
    // classifier_out = CLASS_SKL(input_classifier_ch)

     //View the output path to confirm
    // classifier_out.view()

    // Create a channel for the input classifier_skl2
     // input_classifier2_ch = Channel.fromPath(params.taxonomy_qza, checkIfExists: true)

    // Run the PHYLOGEN_ALIGN process
     // classifier2_out = CLASS_SKL2(input_classifier2_ch)

    //View the output path to confirm
    // classifier2_out.view()

     //Create a channel for the taxa_barplot input files
   // input_taxa_ch = Channel.fromPath(params.table_qza, checkIfExists: true)
                             //  .combine(Channel.fromPath(params.taxonomy_qza, checkIfExists: true))
                             //  .combine(Channel.fromPath(params.metadata_file, checkIfExists: true))
                             //  .map {table_qza, taxonomy_qza, metadata_file -> tuple(table_qza, taxonomy_qza, metadata_file)}
    
    // Run the TAXA_BARPLOT process
    // taxa_out = TAXA_BARPLOT(input_taxa_ch)

     //View the output path to confirm
    // taxa_out.view()

     // Run the FILTER_SAMPLES process
     //filter_results = FILTER_SAMPLES(
     //tuple(params.table_qza, params.metadata_file),
     //beta_value_channel)

     //View the output path to confirm
     //filter_results.view()

     // Run the COMPOSITION_DATA process
     //composition_results = COMPOSITION_DATA(
     //tuple(params.gut_table, params.metadata_file),
     //beta_value2_channel)

     //View the output path to confirm
     //composition_results.view()

     // Run the COMPOSITION_DATA2 process
     //composition2_results = COMPOSITION_DATA2(params.ancombc)

     //View the output path to confirm
     //composition2_results.view()
    
    // Run the TAXA_COLLAPSE process
     taxa_results = TAXA_COLLAPSE(
     tuple(params.gut_table, params.taxonomy_qza, params.metadata_file),
     beta_value2_channel)

     // Split the outputs and view them individually
     taxa_results[0].view()  // View gut-table-l6.qza
     taxa_results[1].view()  // View l6-ancombc-subject.qza

     // Run the COMPOSITION_BARPLOT process
     comp_results = COMPOSITION_BARPLOT(params.ancombc)

     // View the output path to confirm
     comp_results.view()

}

/*
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    THE END
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
*/



