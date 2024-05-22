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

BEGIN {
FS="\t"
}
{
    calc[$2][0]+=1;
    calc[$2][1]+= -v $7;
    calc[$2][2]+= -v $8;
    calc[$2][3]+= -v ($7*$8);
    calc[$2][4]+= -v ($7*$7);
    calc[$2][5]+= -v ($8*$8); 
