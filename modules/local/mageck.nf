
process MAGECK_COUNT {

    input:
        tuple path(lib), path(fastqs)

    output:
      path("count.txt")

    script:
    """
    mageck count \\
      -l ${lib} \\
      --fastq ${fastqs.join.(' ')}
    """

}

process MAGECK_TEST {
    input:
      tuple path(count), val(treatment), val(control)

    output:
      path("gene_summary.txt")

    script:
    """
    mageck test \\
      -k ${count} \\
      -t ${treatment.join(',')} \\
      -c ${control.join(',')}
    """
}


process VISPR { // TODO
    output:
        path("output.txt")

    script:
    """
    uname -a >> output.txt
    which vispr >> output.txt
    """
}
