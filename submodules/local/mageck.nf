
include { MAGECK_TEST as TEST } from "../../modules/local/mageck.nf"
include { MAGECK_MLE as MLE   } from "../../modules/local/mageck.nf"

workflow MAGECK {
    take:
        count
        treat
        ctrl

    main:
        TEST(count, treat, ctrl)

        if (params.design_matrix) {
            MLE(count, file(params.design_matrix))
            mle_gene = MLE.out.gene
            mle_sgrna = MLE.out.sgrna
        } else {
            mle_gene = null
            mle_sgrna = null
        }

    emit:
        test_gene  = TEST.out.gene
        test_sgrna = TEST.out.sgrna
        mle_gene   = mle_gene
        mle_sgrna  = mle_sgrna

}
