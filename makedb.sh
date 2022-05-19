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
#SBATCH --time=06:00:00
### memory size required per node (this is important, you also need to estimate a upper bound)
#SBATCH --mem=128GB
### select the partition "def" (this is the default partition but you can change according to your application)
#SBATCH --partition=def

module load diamond/2.0.9

DATA_PATH=/ifs/groups/eces450650Grp/ECES450650_SP22/diamond
INPUT_FILE_NAME=uniprot.fasta.gz
DB_NAME=uniprot_diamond

# create the diamond database if it doesnt exist already
if [ ! -f "$DATA_PATH/$DB_NAME.dmnd" ]
then
	echo "Database does not exist. Creating it..."
	diamond makedb --in $DATA_PATH/$INPUT_FILE_NAME \
		       -d $DATA_PATH/$DB_NAME \
		       --taxonmap $DATA_PATH/prot.accession2taxid.FULL.gz \
		       --taxonnodes $DATA_PATH/nodes.dmp \
		       --taxonnames $DATA_PATH/names.dmp
else
	echo "Database exists. Exiting..."
fi

