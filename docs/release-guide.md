# Release Guide

## How to test a pre-release on biowulf

Install the development version of crispin.

```sh
# activate the conda env for development
. "/data/CCBR_Pipeliner/db/PipeDB/Conda/etc/profile.d/conda.sh"
conda activate py311

# go to the source on biowulf and update
cd /data/CCBR_Pipeliner/Pipelines/CRISPIN/crispin-dev
git pull
# optionally switch to different branch if needed

# install the version to a hidden path (e.g. .v0.1.0, .v1.0.0.9000) in /data/CCBR_Pipeliner/Pipelines/CRISPIN
cd ..
pip install ./crispin-dev -t ./.v0.1.0
# add it to your PATH and PYTHONPATH with:
export PATH="$PATH:/data/CCBR_Pipeliner/Pipelines/CRISPIN/.v0.1.0/bin/"
export PYTHONPATH="$PYTHONPATH:/data/CCBR_Pipeliner/Pipelines/CRISPIN/.v0.1.0/"
```

## Add CRISPIN to the ccbrpipeliner module on biowulf

Create a lua file in `/data/CCBR_Pipeliner/modules/ccbrpipeliner`, e.g. `dev.lua`.
You can copy the most recent lua file to use as a base, then modify the following line:

```lua
source_sh("bash", "/data/CCBR_Pipeliner/Pipelines/CRISPIN/crispin-dev/bin/install.sh .v0.1.0")
```

Change the version of CRISPIN as needed. Notice the dot (`.`) in front of the version number to indicate a hidden path.

Then use and load the module (substitute `dev` for whatever you named the new lua file) with:

```sh
module use /data/CCBR_Pipeliner/modules
module load ccbrpipeliner/dev
```
