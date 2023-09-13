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

process BAGEL {
    output:
        path("output.txt")

    script:
    """
    uname -a >> output.txt
    which BAGEL.py >> output.txt
    """
}

process DRUGZ {
    output:
        path("output.txt")

    script:
    """
    uname -a >> output.txt
    which drugz.py >> output.txt
    """
}

process MAGECK {
    output:
        path("output.txt")

    script:
    """
    uname -a >> output.txt
    which mageck >> output.txt
    """
}

process VISPR {
    output:
        path("output.txt")

    script:
    """
    uname -a >> output.txt
    which vispr >> output.txt
    """
}

process BASE {
    output:
        path("output.txt")

    script:
    """
    uname -a >> output.txt
    python -V >> output.txt
    """
}
workflow {
    BASE()
    DRUGZ()
    BAGEL()
    MAGECK()
    VISPR()
    INPUT_CHECK(file(params.input), params.seq_center)
    INPUT_CHECK.out.reads.set{ raw_fastqs }
    raw_fastqs | TRIM_SE
}
