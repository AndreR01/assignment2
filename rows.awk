#!usr/bin/env awk
# Author: Andre Rampono
# Student: 23840638

#### FUNCTION BEGINS
# Excludes rows in the data that do not contain a country code.
# 
# ARGUMENTS:
#   $1: tsv data file
# OUTPUTS
#   FILE:
#   STDERR:
#   RETURNS: 
### FUNCTION END

BEGIN{
FS="\t";
OFS=FS
}
{
   if (!($2=="")) {print;}
}
