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

#TODO do i need a check usage line here?
system("if [[ $# -ne 1 ]]; then echo "Usage: $0 <datafile>." > /dev/stderr exit 0
fi")


#if [[ $# -ne 1 ]]
#then
#    echo "Usage: $0 <datafile>." > /dev/stderr
#    exit 0
#fi
#BEGIN {ARGV[1] != 1; print "Usage"; print "All good"}


# exclude date outside range and rows with country code data
BEGIN {FS="\t"; OFS=FS} (int($3) < 2011 || int($3) > 2021) || $2 == "" {next;} {print $0 > "_awkl"} "$1"
