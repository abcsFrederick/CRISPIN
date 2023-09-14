
process MAGECK_TEST {
    label 'mageck'

    input:
      path(count)
      val(treatment)
      val(control)

    output:
      path("*.gene_summary.txt"), emit: gene_sum
      path("*.sgrna_summary.txt"), emit: sgrna_sum

    script:
    """
    mageck test \\
      -k ${count} \\
      -t ${treatment.join(',')} \\
      -c ${control.join(',')} \\
      -n ${count.getBaseName(2)}
    """

    stub:
    """
    for ext in gene sgrna; do
        touch ${count.getBaseName(2)}.\${ext}_summary.txt
    done
    """
}

process MAGECK_MLE {
    label 'mageck'

    input:
        path(count)
        path(design)

    output:
        path("*.gene_summary.txt"), emit: gene_sum
        path("*.sgrna_summary.txt"), emit: sgrna_sum

    script:
    """
    mageck mle \\
      -k ${count} \\
      -d ${design} \\
      -n ${count.getBaseName(2)}
    """

    stub:
    """
    for ext in gene sgrna; do
        touch ${count.getBaseName(2)}.\${ext}_summary.txt
    done
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
