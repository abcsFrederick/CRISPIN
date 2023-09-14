# CRUISE 🛳️

**C**rispr sc**R**een seq**U**encIng analy**S**is pip**E**line

🚧 **This project is under active development. It is not yet ready for production use.** 🚧

[![build](https://github.com/CCBR/CRUISE/actions/workflows/build.yml/badge.svg)](https://github.com/CCBR/CRUISE/actions/workflows/build.yml)

## Usage

Run the test profile with stubs to see which processes will run

```sh
CRUISE run -profile test,singularity -stub
```

Run the test profile

```sh
CRUISE run -profile test,singularity
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
