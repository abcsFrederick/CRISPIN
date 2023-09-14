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
include { TRIM_ALIGN  } from './submodules/local/trim_align.nf'
include { MAGECK      } from './submodules/local/mageck.nf'

workflow CRUISE {
    INPUT_CHECK(file(params.input))
    INPUT_CHECK.out
        .reads
        .set { raw reads }

    ch_count = params.count_table ? file(params.count_table, checkIfExists: true) : null
    if (!ch_count) { // trim reads and run mageck count
        TRIM_ALIGN(raw_reads, file(params.library))
        ch_count = TRIM_ALIGN.out.count
    }

    raw_reads
      .branch { meta, fastq ->
        treat: meta.treat_or_ctrl == 'treatment'
            return meta.id
        ctrl: meta.treat_or_ctrl == 'control'
            return meta.id
      }
      .set { treatments }

    MAGECK(ch_count, treatments.treat.collect(), treatments.ctrl.collect())

}

workflow {
    CRUISE()
}
