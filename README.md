# CRUISE 🛳️

**C**rispr sc**R**een seq**U**encIng analy**S**is pip**E**line

🚧 **This project is under active development. It is not yet ready for production use.** 🚧

[![build](https://github.com/CCBR/CRUISE/actions/workflows/build.yml/badge.svg)](https://github.com/CCBR/CRUISE/actions/workflows/build.yml)

## Set up

Cruise is installed on the [Biowulf HPC](#biowulf).
For installation in other execution environments,
refer to the [docs](https://ccbr.github.io/cruise).

### Biowulf

Cruise is available on [Biowulf](https://hpc.nih.gov/) in the `ccbrpipeliner` module.
You'll first need to start an interactive session and create a directory from where you'll run cruise.

```sh
# start an interactive node
sinteractive --mem=2g --cpus-per-task=2 --gres=lscratch:200
# make a working directory for your project and go to it
mkdir -p /data/$USER/crisprseq
cd /data/$USER/crisprseq
# load the ccbrpipeliener module
module load ccbrpipeliner
```

## Usage

Initialize and run cruise with test data:

```sh
# copy the cruise config files to your current directory
cruise init
# preview the cruise jobs that will run with the test dataset
cruise run --mode local -profile test -preview
# launch a cruise run on slurm with the test dataset
cruise run --mode slurm -profile test,biowulf
```

To run cruise on your own data, you'll need to create a sample sheet.
Take a look at the example: 
[assets/samplesheet_test_biowulf.csv](assets/samplesheet_test_biowulf.csv).

You'll also need to select an appropriate library for your dataset.
CRUISE is bundled with several libraries in [assets/lib](assets/lib),
or you can download your own.
Once you've created a samplesheet with paths to your fastq files,
run cruise with the `--input` option to specify the path to your sample sheet
and `--library` for the path to your library file:

```sh
cruise run --mode slurm -profile biowulf --input samplesheet.csv --library assets/lib/yusa_library.csv
```

## Help & Contributing

Come across a **bug**? Open an [issue](https://github.com/CCBR/CRUISE/issues) and include a minimal reproducible example.

Have a **question**? Ask it in [discussions](https://github.com/CCBR/CRUISE/discussions).

Want to **contribute** to this project? Check out the [contributing guidelines](docs/CONTRIBUTING.md).

## References

This repo was originally generated from the [CCBR Nextflow Template](https://github.com/CCBR/CCBR_NextflowTemplate).
The template takes inspiration from nektool[^1] and the nf-core template.
If you plan to contribute your pipeline to nf-core, don't use this template -- instead follow nf-core's instructions[^2].

[^1]: nektool https://github.com/beardymcjohnface/nektool
[^2]: instructions for nf-core pipelines https://nf-co.re/docs/contributing/tutorials/creating_with_nf_core
