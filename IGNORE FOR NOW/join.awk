#!usb/bin/env bash
BEGIN {
FS="\t";
getline
NR=0
OFS=FS
}
FNR == NR {
	key[$2 $3]=$7;
}
FNR < NR {
	k=$2 $3;
	if(k in key) {
		delete key[k]
		print;
	}else{
		print $5
	}
}
END {
	for(i in key){
		print key[i]
	}
}
