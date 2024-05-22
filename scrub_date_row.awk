#!usr/bin/env awk
# Author: Andre Rampono
# Student: 23840638

#### FUNCTION BEGINS
# Excludes rows of data that fall outside the required date range
# Creates a key in Column 9 to for seartch filtering purposes
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
    $9 = $8 ($2$3)
}
{
    if ($3>2010 && $3<2022){print;}
}

