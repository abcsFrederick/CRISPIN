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
include { TRIM_SE } from './modules/local/trim.nf'

workflow CRUISE {
    INPUT_CHECK(file(params.input), params.seq_center)
    INPUT_CHECK.out.reads.set{ raw_fastqs }
    raw_fastqs | TRIM_SE
}

workflow {
    CRUISE()
}
