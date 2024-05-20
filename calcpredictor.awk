#!usb/bin/env awk
# Author: Andre Rampono
# Student: 23840638

#### FUNCTION BEGINS
# Exclude dates outside range and rows with no country code data in column 2
# 
# ARGUMENTS:
#   $1: csv data file
#   $2: three letter ISO or year
#   $3: gender of smoking population
# OUTPUTS
#   STDOUT: if $2 is a three letter ISO, the year and maximum rate of $3
#   STDOUT: if $2 is a year, the country with the highest rate
#   STDOUT: ALL queries should return: country name & code; year; and
#           rate for that country in that year
#   STDERR: All errors
### FUNCTION END


BEGIN {
FS="\t"
}
{
    calc[$2][0]+=1;
    calc[$2][1]+= -v $4;
    calc[$2][2]+= -v $8;
    calc[$2][3]+= -v ($4*$8);
    calc[$2][4]+= -v ($4*$4);
    calc[$2][5]+= -v ($8*$8);
}
END{
    for (d in calc){
            c=calc[d][0];
            sx=calc[d][1];sy=calc[d][2];
            sxy=calc[d][3];
            sx2=calc[d][4];
            sy2=calc[d][5];
            correlation=( c * sxy - sx * sy ) / ( sqrt(c*sx2 - sx*sx) * sqrt(c*sy2 - sy * sy));
            print d, c, "Correlation is ", correlation
        }
}

