#!/usr/bin/env awk

BEGIN {
    Colours["Yemen"][1] = "4.5137"
    Colours["Yemen"][2] = "4"
    Colours[1][3] = "5"
    Colours[2][1] = "6.1"
    Colours[2][2] = "2.3"
    Colours[2][3] = "1.1"
}
END {
    sum = 0
    for (i in Colours) {
        if (isarray(Colours[i])) {
            for (j in Colours[i]) {
                print Colours[i][j]
                sum=$sum+(int($j))
            }
        }
        else
            print array[i]
    }
    {print sum}
}

