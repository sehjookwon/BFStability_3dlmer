#!/bin/bash
#SBATCH --job-name=BFStability
#SBATCH --output=output/BFStability.log
#SBATCH --time=3-00:00:00
#SBATCH --cpus-per-task=15
#SBATCH --ntasks=1
#SBATCH --mem=40g
#SBATCH --partition=general
#SBATCH --constraint="[rhel7|rhel8]"

module load afni/20.3.00 
module load r/3.6.0 

echo 'R_LIBS_USER="~/R/libs"' >  $HOME/.Renviron
export R_MAX_VSIZE=32000000000

3dLMEr -prefix BFStability -jobs 28 \
 -model 'Grade7*BF_TVC+NRI_Between+NRI_Within+TimeBetween_1C+(1|Subj)' \
 -qVars "Grade7,NRI_Between,NRI_Within,TimeBetween_1C" \
 -qVarCenters "0,0,0,0" \
 -dataTable \
