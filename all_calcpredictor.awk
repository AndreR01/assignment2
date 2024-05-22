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
#    large_no = 1.0e300
#    max = -large_no
#    min = large_no

    calc[$1][0]= $1;
    calc[$1][1]= $2;
    calc[$1][2]= $3;
    calc[$1][3]= $4;
    printf("Mean correlation of %s with Cantril ladder is %.3f\n"), calc[$1][0], calc[$1][1]



#    calc[$1][1] > 0 ? comp=calc[$1][1] : -calc[$1][1]
#    print calc[$1][1]
    #if( comp > max)
    #    max=comp
    #    predictor=calc[$1][0]
    #if(comp < min)
#        min = comp

}
 
END{






    #printf("Max %.3f withpredictor %s."), max, predictor
    #for (x in calc){
     #   print x
     #   print calc[x][1]
        #mean=calc[x][1]
        #check=calc[x][2];
        #more=calc[x][3];
    #    printf("Mean correlation of %s Rate with Cantril ladder is %.3f check is %s\n"), predictor, mean, check
       # printf("Mean correlation of %s Rate with Cantril ladder is %.3f\n"), predictor, mean
    }
    #printf("Mean correlation of %s Rate with Cantril ladder is %.3f check is %s, more is %s\n"), predictor, mean, check, more
#    for (y in calc){
#        print y
        #predictor=calc[y][0];
        #mean=calc[y][1];
        #check=cal[y][2];
        #more=calc[x][3];
        #printf("Mean correlation of %s Rate with Cantril ladder is %.3f check is %s\n"), predictor, mean, chec
        #printf("Mean correlation of %s Rate with Cantril ladder is %.3f\n"), predictor, mean
#} 
#    printf("Mean correlation of %s Rate with Cantril ladder is %.3f check is %s, more is %s\n"), predictor, mean, check, more

  

