#!/bin/bash
#
### !!! CHANGE !!! the email address to your drexel email
#SBATCH --mail-user=pdh46@drexel.edu
### !!! CHANGE !!! the account - you need to consult with the professor
#SBATCH --account=eces450650Prj
### select number of nodes (usually you need only 1 node)
#SBATCH --nodes=1
### select number of tasks per node
#SBATCH --ntasks=1
### select number of cpus per task (you need to tweak this when you run a multi- thread program)
#SBATCH --cpus-per-task=1
### request 15 minutes of wall clock time (if you request less time, you can wait for less time to get your job run by the system, you need to have a good estimation of the run time though).
#SBATCH --time=00:10:00
### memory size required per node (this is important, you also need to estimate a upper bound)
#SBATCH --mem=1GB
### select the partition "def" (this is the default partition but you can change according to your application)
#SBATCH --partition=def

module load diamond

# convert fastq files to fasta files
sed -n '1~4s/^@/>/p;2~4p' /ifs/groups/eces450650Grp/data/mappings/evol1.sorted.unmapped.R1.fastq > tmp1.fasta
sed -n '1~4s/^@/>/p;2~4p' /ifs/groups/eces450650Grp/data/mappings/evol1.sorted.unmapped.R2.fastq > tmp2.fasta

# create the diamond databases
diamond makedb --in tmp1.fasta -d evol1.sorted.unmapped.R1 --taxonmap gene_refseq_uniprotkb_collab.gz
diamond makedb --in tmp2.fasta -d evol1.sorted.unmapped.R2 --taxonmap gene_refseq_uniprotkb_collab.gz

# remove the unneeded fasta files
rm tmp1.fasta
rm tmp2.fasta
