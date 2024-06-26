#!/usr/bin/env bash

# Check CLI for valid number of arguments
if [[ $# -ne 1 ]]; then
	echo "Usage: $0 <tsv datafile> <tsv datafile> <tsv datafile>." > /dev/stderr
	exit 1
fi

# Check the file contains data
for arg in "$@"; do
if [[ ! -s $arg ]]; then
	echo "Error: The file $arg does not exist or is not readable." > /dev/stderr
        exit 1
	fi
done

# delete header. causes issue with data processing
# delete blank lines - 
tail -n +2 $1 | grep -v '^[[:space:]]*$' > _tmp_noHeader 

# check there are at least three values in the list/array

# account for the 0's - especially in homicide

# Delete the header
awk -F'\t' 'BEGIN {OFS=FS} ($4 == "" || $5 == "" || $6 == "" || $7 == "") || $8 == "" {next;} {print $0}' _tmp_noHeader > _tmp_predictorData


awk -f calcpredictor.awk _tmp_predictorData > _checkCalcPredictor



#cut -f2-3 _tmpCleanRow.tsv | awk 'BEGIN {FS="\t"; OFS=FS} {$4=$1$2}1' | tail -n +2 > _tmpCodeYear
#cut -f1 _tmpCodeYear | sort -u -k1 > _tmpCode

# iterate over the codes. if the country code is in the second row, send it to the corr calc and place value in an array
# if there aren't three values to calculate return null
# calculate mean of each predictor

#awk 'BEGIN { 
#FS="\t";
#getline
#NR=0
#OFS=FS
#}

#
#function filterLine(num_fields){
#row must have all four data points and cantril ladder score
#}

# CALCULATE PREDICTOR WITH LARGEST ABSOLUTE VALUE
#function max(a, b)
#{
#if(a>=b)
#return(a)
#return(b)
#}
#{print max($1, $2)}

# CALCULATE CORRELATION
#https://www.unix.com/shell-programming-and-scripting/154844-calculate-correlation-between-two-fields.html
# get every x and every y and put into an array
#awk -F'\t' -v c="10" '
#{ d=$1; for(i=c;i;i--) {
#    x[i]=x[i-1]
#    y[i]=y[i-1] }
#    x[0]=$3
#    y[0]=$4
#}
#END { for(i=0;i<c;i++) {
#        sx+=x[i]
#        sy+=y[i]
#        sxy+=x[i]*y[i]
#        sx2+=x[i]*x[i]
#        sy2+=y[i]*y[i] }
#    print d, c, ( c * sxy - sx * sy ) / ( sqrt(c*sx2 - sx*sx) * sqrt(c*sy2 - sy * sy))
#}' OFS='\t' $1 > _corrFile

# Calculations
# count the number of inputs
# (every x * every y) * number of inputs
# sum of x
# sum of y
# SQRT((number of inputs * (sum every x * x)) * ((sum of x)(sum of x)) * SQRT((number of inputs * ( sum every y * y))* ((sum of y)(sum of y))
# sum of each predictor / number of input predictors

# Author: Andre Rampono
# Student: 23840638
# set -x
# Take the input from cantril_data_cleaningn as a input.
# For each country calucuate the Pearson correlation between the predictor variable
# given Cantril Ladder score.
# Calculate the mean correlation of a predictor and the best predictor will have the largest absolute value



