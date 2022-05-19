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
#SBATCH --time=10:00:00
### memory size required per node (this is important, you also need to estimate a upper bound)
#SBATCH --mem=16GB
### select the partition "def" (this is the default partition but you can change according to your application)
#SBATCH --partition=def

DATA_PATH=/ifs/groups/eces450650Grp/ECES450650_SP22/diamond

### old method for retrieving data, way to slow for large datasets
#gzip -dk $DATA_PATH/gene_refseq_uniprotkb_collab.gz
#sed '1d' $DATA_PATH/gene_refseq_uniprotkb_collab > $DATA_PATH/all_uniprot
#cut -f2 $DATA_PATH/all_uniprot > $DATA_PATH/uniprot_ids
#touch $DATA_PATH/data.fasta

#for ID in $(cat $DATA_PATH/uniprot_ids)
#do
#	wget https://www.uniprot.org/uniprot/$ID.fasta
#	cat $ID.fasta >> $DATA_PATH/data.fasta
#	rm $ID.fasta
#done

#rm $DATA_PATH/gene_refseq_uniprotkb_collab
#rm $DATA_PATH/all_uniprot
#rm $DATA_PATH/uniprot_ids

# get the current directory
CUR_DIR=$(pwd)

# change to the directory where we want to store the data
cd $DATA_PATH

# retrieve the uniprot data
wget https://ftp.uniprot.org/pub/databases/uniprot/current_release/knowledgebase/complete/uniprot_sprot.fasta.gz
wget https://ftp.uniprot.org/pub/databases/uniprot/current_release/knowledgebase/complete/uniprot_trembl.fasta.gz

# leave the dir, we don't need to be in it anymore
cd $CUR_DIR

# combine the two dbs into one
cat $DATA_PATH/uniprot_sprot.fasta.gz $DATA_PATH/uniprot_trembl.fasta.gz > $DATA_PATH/uniprot.fasta.gz

# remove the individual files now that we have combined one
rm $DATA_PATH/uniprot_sprot.fasta.gz
rm $DATA_PATH/uniprot_trembl.fasta.gz

