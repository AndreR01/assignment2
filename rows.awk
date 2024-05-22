#!usr/bin/env awk
# Author: Andre Rampono
# Student: 23840638

#### FUNCTION BEGINS
# Takes the filtered data of countries, and outputs a file containing the correlation of each predictor against the cantril ladder score
# 
# ARGUMENTS:
#   $1: tsv data file
# OUTPUTS
#   FILE: for each country with vailid data, a row the country, number data points used and the correlation to the country's cantril ladder score  
#   STDERR: 
### FUNCTION END

BEGIN{
FS="\t";
OFS=FS
}
{
   if (!($2=="")) {print;}
}
