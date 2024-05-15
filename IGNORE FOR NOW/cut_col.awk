#!/usr/bin/env awk

BEGIN{
    if (COL == "")
        COL = 3
}
NF >= COL {
    for(i=3; i<COL; i++)
        printf("%s\n", $i)
    for(j=i+1; j<+NF; j++)
        printf("%s\t", $j)
}
