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
    calc[$2][1]+= -v $4;
    calc[$2][2]+= -v $8;
    calc[$2][3]+= -v ($4*$8);
    calc[$2][4]+= -v ($4*$4);
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
        #TODO What if px or py is 0
        # Excludes some countries for the calculation??
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
#       printf ("%s\t%d\t Correlation is:\t %.16f\n"), d,c,correlation
        #TODO is there a danger in running totals?
        sum+=1
        total+=c
	    sum_corr+=correlation
	    mean=sum_corr/sum
        }
}
printf ("GDP\t %.3f\n"), mean
}
