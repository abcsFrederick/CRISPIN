## development version

- Run spooker on workflow completion.
- Print the recommended citation in bibtex format with `crispin --citation`. (#32, @kelly-sovacool)
- Fix citation information (#38, @kelly-sovacool)

## CRISPIN 0.1.1

### Bug fixes

- All scripts in the bin directory are now made executable for all users on biowulf (#25).
- Data directories are copied recursively during python package installation (#26).

## CRISPIN 0.1.0

This is the first release of CRISPIN 🎉

### New features

- Trim adapters with cutadapt.
- Run mageck count. (#9)
  - `mageck count` only runs if a count table **isn't** given.
- Optional: run mageck test and mle. (#9)
  - `mageck mle` only runs if a design matrix **is** given.
- Optional: run drugZ. (#10)
- Optional: run BAGEL2. (#11)
  - fc (fold change)
  - bf (bayes factor)
  - pr (precision recall)
- CLI (#16)
  - `crispin init` to initialize a project directory.
  - `crispin run`
    - `--mode slurm` to submit a slurm job to biowulf or frce.
    - `--main path/to/main.nf` to select a different local install of crispin, or specify the repo (`CCBR/CRISPIN`) to get it from GitHub.
