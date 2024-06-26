#!/usr/bin/env bash
# Author: Andre Rampono
# Student: 23840638
#set -x
# Data cleaning script to take three arguments, clean the data and send resulting data to STDOUT
#### FUNCTION BEGINS
# Given three tsv data files, clean each file for a date range (2011-2021),
# remove the Continent column from GDP and Life files as well as rows
# that do not contain a Code for the associated Entity column
# Format of results depends on $2 input
# ARGUMENTS:
#   $1: tsv data file
#   $2: tsv data file
#   $3: tsv data file
# OUTPUTS
#   STDOUT: the cleaned data of the three input files combined from selected columns
#           to derive the best predictor of Cantril-ladder life-satisfaction scores.
#   STDERR: All errors
### FUNCTION END

# Check CLI for valid number of arguments
if [[ $# -ne 3 ]]; then
    echo "Usage: $0 <tsv datafile> <tsv datafile> <tsv datafile>." > /dev/stderr
    exit 1
fi

# Check file for validity
for arg in "$@"; do
    if [[ ! -s $arg ]]; then
        echo "Error: The file $arg does not exist or is not readable." > /dev/stderr
        exit 1
    fi
done

#TODO Implement a loop to compare the current line NF to the head NF and alert if different
# Check each line against header tabs
# best predictor of Cantril-ladder life-satisfaction scores
for arg in "$@"; do
    num_col=$(head -n1 $arg | awk -F'\t' '{print NF;exit}')
    awk -v cols=$num_col '{if (NF != cols) {printf"Compared to the header line, LINE %d is missing missing cells \n", NR}}' $arg > /dev/stderr
done

# Search header for key word to differentiate files
for arg in "$@"; do
    header=$(head -1 "$arg")
    if echo "$header" | grep -E -q [Ll]ife; then
        #TODO How to reuse script in awk?
        #awk -f scrub_date_row.awk "$arg" 
        #| sort -k1,1 -k3,3n | cut -f1-6 > _life
        # exclude date outside range and rows with country code data
        awk -F'\t' 'BEGIN {OFS=FS} (int($3) < 2011 || int($3) > 2021) || $2 == "" {next} {print $0}' "$arg" | sort -k1,1 -k3,3n | cut -f1-6 > _life
        #create the combination key of country code and year
        awk 'BEGIN {FS="\t"; OFS=FS} {$9=$2$3}1' _life | sort -t $'\t' -k9 > _tmplife

    elif echo "$header" | grep -E -q [Gg][Dd][Pp]; then
        awk -F'\t' 'BEGIN {OFS=FS} (int($3) < 2011 || int($3) > 2021) || $2 == "" {next} {print $0}' "$arg" | sort -k1,1 -k3,3n | cut -f1-6 > _gdp
        awk 'BEGIN {FS="\t"; OFS=FS} {$9=$2$3}1' _gdp | sort -t $'\t' -k9 > _tmpgdp

    elif echo "$header" | grep -q [Hh]omicide; then
        awk -F'\t' 'BEGIN {OFS=FS} (int($3) < 2011 || int($3) > 2021) || $2 == "" {next} {print $0}' "$arg" | sort -k1,1 -k3,3n | cut -f1-4 > _homicide
        awk 'BEGIN {FS="\t"; OFS=FS} {$9=$2$3}1' _homicide | sort -t $'\t' -k9 > _tmphomicide
    fi
done

# Extract combo key from each file to capture all possible available data
cut -f9 _tmplife | awk '{print $0}' | sort -u -k1 > _cutLife
cut -f9 _tmpgdp |  awk '{print $0}' | sort -u -k1 > _cutGdp
cut -f9 _tmphomicide |  awk '{print $0}' | sort -k1  > _cutHomi 

# join the combo key columns from each file into a single source
join -a 1 -a 2 -t $'\t' -1 1 -2 1 -o 0,1.1,2.1 _cutGdp _cutHomi > _tmpCut
join -a 1 -a 2 -t $'\t' -1 1 -2 1 -o 0,1.1,2.1 _tmpCut _cutLife | cut -f1 | sort -u -k1> _tmpAll

# use the combined combo key to filter the required columns and rows from each file
# append the common merged column column 1 of the new file
join -a 1 -a 2 -e '' -t $'\t' -1 1 -2 9 -o 0,2.1,2.2,2.3,2.5,2.6,1.1,1.1,1.1,2.9,1.1 _tmpAll _tmpgdp > _gdpDone
join -a 1 -a 2 -e '' -t $'\t' -1 1 -2 9 -o 0,2.1,2.2,2.3,2.4,1.1,1.1,1.1,1.1,2.9,1.1 _tmpAll _tmphomicide > _homicideDone
join -a 1 -a 2 -e '' -t $'\t' -1 1 -2 9 -o 0,2.1,2.2,2.3,2.4,2.5,1.1,1.1,1.1,2.9,1.1 _tmpAll _tmplife > _lifeDone

# join the filtered files with each other on the combo key in the first column
join -a 1 -a 2 -e '' -t $'\t' -1 1 -2 1 -o 0,1.2,1.3,1.4,1.5,1.6,2.5,1.1,1.1,1.1 _gdpDone _homicideDone > _clean1

# final join adding the merged column as the last column
join -a 1 -a 2 -e '' -t $'\t' -1 1 -2 1 -o 1.2,1.3,1.4,1.5,1.6,1.7,2.5,2.6 _clean1 _lifeDone  | sort -k1,1 -k3,3n | cut -f1-8 > _cantril_data_gaps

# remove new lines without a country code created from the joins
awk -F'\t' 'BEGIN {OFS=FS} $2 == "" {next} {print $0}' _cantril_data_gaps | sort -k1,1 -k3,3n  > _cantril_data_blanks

# create header file
awk 'BEGIN {FS="\t"; OFS=FS; print "Entity","Code", "Year", "GDP per capita, PPP (constant 2017 international $)", "Population (historical estimates)", "Homicide rate per 100,000 population - Both sexes - All ages", "Life expectancy - Sex: all - Age: at birth - Variant: estimates", "Cantril ladder score" > "_cantril_data_done"}'

# remove new blank lines created from the joins
awk -F'\t' 'BEGIN {OFS=FS} $4 == "" && $5 == "" && $6 == "" && $7 == "" && $8 == "" {next;} {print $0}' _cantril_data_blanks >> _cantril_data_done 

#TODO enable cat cmd
#cat _cantril_data_done

 

# clean up temp files
rm ./_*
