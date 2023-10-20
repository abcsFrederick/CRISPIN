include { FOLD_CHANGE      } from '../../modules/local/bagel.nf'
include { BAYES_FACTOR     } from '../../modules/local/bagel.nf'
include { PRECISION_RECALL } from '../../modules/local/bagel.nf'

workflow BAGEL {
    take:
        count
        ctrl

    main:
        FOLD_CHANGE(count, ctrl)
        BAYES_FACTOR(FOLD_CHANGE.out.fc)
        PRECISION_RECALL(BAYES_FACTOR.out.bf)

    emit:
        fold_change = FOLD_CHANGE.out.fc
        count_norm = FOLD_CHANGE.out.count_norm
        bayes_factor = BAYES_FACTOR.out.bf
        prec_rec = PRECISION_RECALL.out.pr
}
