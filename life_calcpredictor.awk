#!usr/bin/env awk
# Author: Andre Rampono
# Student: 23840638

#### FUNCTION BEGINS
# Calculates the mean correlation of life satisfaction-vs-life expectancy predictore across all valid data
# 
# ARGUMENTS:
#   $1: tsv data file
# OUTPUTS
#   FILE:
#   STDERR:
#   RETURNS: 
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
}
END{
    for (d in calc){
        c=calc[d][0];
        sx=calc[d][1];
        sy=calc[d][2];
        sxy=calc[d][3];
        sx2=calc[d][4];
        sy2=calc[d][5];
        px=(c*sx2 - sx*sx)
        py=(c*sy2 - sy*sy)
        dxy=0
        if (px == 0 || py == 0){
            }
            else if (px < 0 && py < 0) {
                dxy=(sqrt(px * -1) * sqrt(py * -1))
                correlation=( c * sxy - sx * sy ) / dxy
            }
            else if (px < 0) {
                dxy=(sqrt(px * -1) * sqrt(py))
                correlation=( c * sxy - sx * sy ) / (dxy * -1)
            }
            else if (py < 0) {
                dxy=(sqrt(px) * sqrt(py*-1))
                correlation=( c * sxy - sx * sy ) / (dxy * -1)
            }
            else {
                correlation=( c * sxy - sx * sy ) / ((sqrt(c * sx2 - sx * sx) * sqrt(c * sy2 - sy * sy)));
	    sum+=1
        total+=c
	sum_corr+=correlation
	mean=sum_corr/sum
        }
}
printf("Life Expectancy\t %.3f\n"), mean
}
