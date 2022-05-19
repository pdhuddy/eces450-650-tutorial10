ECES 450-650 Tutorial 10

This is the public repo for Tutorial 10 of ECES 450/650 at Drexel University

The tutorial assumes that you have access to Drexel's high performance computing cluster: Picotte

All of the data is available in the directory /ifs/groups/eces450650Grp/ECES450650_SP22/diamond/
You do not need to run generate_data.sh, but it is there for reference for if you can not use picotte

makedb.sh generates the diamond database that is required to run diamond with
the database is made up of all uniprotkb proteins in from both swiss-prot and trembl

tutorial.sh aligns the DNA query sequences against the diamond database
tutorial_mp.sh is a script that will run diamond while taking advantage of distributed computing
