#!usb/bin/env awk
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
OFS=FS;
}
{
    if ((int($3) < 2011 || int($3) > 2021) || $2 == "") {
        next;
    }
    {
        print $0
    }
}   
 
END{
}
