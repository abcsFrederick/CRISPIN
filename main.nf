log.info """\
CRUISE 🛳️
=============
NF version   : $nextflow.version
runName      : $workflow.runName
username     : $workflow.userName
configs      : $workflow.configFiles
profile      : $workflow.profile
cmd line     : $workflow.commandLine
start time   : $workflow.start
projectDir   : $workflow.projectDir
launchDir    : $workflow.launchDir
workDir      : $workflow.workDir
homeDir      : $workflow.homeDir
reads        : ${params.input}
"""
.stripIndent()

// SUBMODULES
include { INPUT_CHECK } from './submodules/local/input_check.nf'

// MODULES
include { TRIM_SE      } from './modules/local/trim.nf'
include { MAGECK_COUNT } from "./modules/local/align.nf"
include { MAGECK_TEST  } from "./modules/local/mageck.nf"
include { MAGECK_MLE   } from "./modules/local/mageck.nf"

workflow CRUISE {
    INPUT_CHECK(file(params.input))
    raw_reads = INPUT_CHECK.out.reads

    ch_count = params.count_table ? file(params.count_table, checkIfExists: true) : null
    if (!ch_count) { // trim reads and run mageck count
        TRIM_SE(raw_reads)
        TRIM_SE.out.reads
        .multiMap { meta, fastq ->
            id: meta.id
            fastq: fastq
        }
        .set{ trimmed_reads }

        MAGECK_COUNT(file(params.library),
                    trimmed_reads.id.collect(),
                    trimmed_reads.fastq.collect()
                    )
        ch_count = MAGECK_COUNT.out.count
    }

    raw_reads
      .branch { meta, fastq ->
        treat: meta.treat_or_ctrl == 'treatment'
            return meta.id
        ctrl: meta.treat_or_ctrl == 'control'
            return meta.id
      }
      .set { treatments }
    MAGECK_TEST(ch_count,
                treatments.treat.collect(),
                treatments.ctrl.collect()
               )

    if (params.design_matrix) {
        MAGECK_MLE(ch_count, file(params.design_matrix))
    }
}

workflow {
    CRUISE()
}
