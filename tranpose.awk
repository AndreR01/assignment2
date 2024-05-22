# Script to transpose data

BEGIN { 
	FS="\t";
	OFS=FS;
} 

#function abs(v) {return v < 0 ? -v : v}

{
    map[$1] = $2
}

END {
    # Iterate over all k
    for (key in map) {
        key == "Life Expectancy";{
            life=map[key]
        }
     printf "%s => %s\n", key, map[key]
     print life
    }
}
