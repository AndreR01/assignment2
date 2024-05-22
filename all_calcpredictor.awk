#!usr/bin/env awk
# Author: Andre Rampono
# Student: 23840638

#### FUNCTION BEGINS
# Iterates over the mean data file and prints to STDOUT.
# 
# ARGUMENTS:
#   $1: tsv data file
# OUTPUTS
#   STDOUT: each predictor and the associated mean correlation of the predictor  
#   STDERR: 
#   RETURNS:	
### FUNCTION END

BEGIN {
FS="\t"
}
{
    calc[$1][0]= $1;
    calc[$1][1]= $2;
    calc[$1][2]= $3;
    calc[$1][3]= $4;
    printf("Mean correlation of %s with Cantril ladder is %.3f\n"), calc[$1][0], calc[$1][1]
}
 
END{
    }
 

  

