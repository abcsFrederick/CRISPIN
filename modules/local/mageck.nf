
process COUNT {
    label 'mageck'
    container 'quay.io/biocontainers/mageck:0.5.9.5--py39h1f90b4d_3'

    input:
        file(lib)
        val(ids)
        path(fastqs)

    output:
      path("*.count.txt"), emit: count
      path("*.count_normalized.txt"), emit: count_norm
      path("*.countsummary.txt"), emit: count_sum

    script:
    """
    mageck count \\
      -l ${lib} \\
      --fastq ${fastqs} \\
      --sample-label ${ids.join(',')} \\
      -n ${params.exp_name}
    """

    stub:
    """
    for ext in count count_normalized countsummary; do
        touch ${params.exp_name}.\${ext}.txt
    done
    uname -a > output.txt
    echo ${task.container} >> output.txt
    """

}

process TEST {
    label 'mageck'
    container 'quay.io/biocontainers/mageck:0.5.9.5--py39h1f90b4d_3'

    input:
      path(count)
      val(treatment)
      val(control)

    output:
      path("*.gene_summary.txt"), emit: gene
      path("*.sgrna_summary.txt"), emit: sgrna

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

process MLE {
    label 'mageck'
    container 'quay.io/biocontainers/mageck:0.5.9.5--py39h1f90b4d_3'

    input:
        path(count)
        path(design)

    output:
        path("*.gene_summary.txt"), emit: gene
        path("*.sgrna_summary.txt"), emit: sgrna

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
    label 'vispr'
    container 'quay.io/biocontainers/mageck-vispr:0.5.6--py_0'

    output:
        path("output.txt")

    script:
    """
    uname -a >> output.txt
    which vispr >> output.txt
    """
}
