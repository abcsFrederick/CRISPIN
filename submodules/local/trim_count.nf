include { TRIM_SE               } from '../../modules/local/trim.nf'
include { COUNT as MAGECK_COUNT } from "../../modules/local/mageck.nf"

workflow TRIM_ALIGN {
    take:
        raw_reads
        library

    main:
        TRIM_SE(raw_reads)
        TRIM_SE.out.reads
        .multiMap { meta, fastq ->
            id: meta.id
            fastq: fastq
        }
        .set{ reads }

        MAGECK_COUNT(library,
                     reads.id.collect(),
                     reads.fastq.collect()
                    )

    emit:
        count = MAGECK_COUNT.out.count
        trimmed_reads = TRIM_SE.out.reads
}
