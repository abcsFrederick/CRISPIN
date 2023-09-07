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
}
