// TODO move this to shared CCBR modules repo
process TRIM_SE {
  tag { meta.id }
  label 'qc'
  label 'process_high'
  container "${params.containers.cutadapt}"

  input:
    tuple val(meta), path(fastq)

  output:
    tuple val(meta), path("*.fastq.gz"), emit: reads

  script:
  def prefix = task.ext.prefix ?: "${meta.id}"
  if (meta.single_end) {
    """
    nseqs_raw=\$(zgrep "^@" ${fastq} | wc -l)
    echo "\$nseqs_raw in ${fastq}"
    cutadapt \
      --nextseq-trim=2 \
      --trim-n \
      -n 5 -O 5 \
      -q ${params.cutadapt.leadingquality},${params.cutadapt.trailingquality} \
      -m ${params.cutadapt.minlen} \
      -b file:${params.cutadapt.adapters} \
      -j $task.cpus \
      $fastq |\
    pigz -p ${task.cpus} > ${prefix}.trimmed.fastq.gz
    nseqs_trimmed=\$(zgrep "^@" ${prefix}.trimmed.fastq.gz | wc -l)
    echo "\$nseqs_trimmed in ${prefix}.trimmed.fastq.gz"
    """
  } else {
    "paired end reads are not supported yet"
  }

  stub:
  """
  touch ${meta.id}.trimmed.fastq.gz
  """
}
