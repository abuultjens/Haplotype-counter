#!/bin/bash

#------------------------------------------------------------------------

# USAGE:
# $ sh Haplotype-counter.sh ISOLATE_alleles.tsv OUT.csv

#------------------------------------------------------------------------

IN=${1}
OUT=${2}

# check for and rm any preexisting files
if ls ${OUT} 1> /dev/null 2>&1; 
then
	rm ${OUT}
fi

# generate random prefix for all tmp files
RAND_1=`echo $((1 + RANDOM % 100))`
RAND_2=`echo $((100 + RANDOM % 200))`
RAND_3=`echo $((200 + RANDOM % 300))`
RAND=`echo "${RAND_1}${RAND_2}${RAND_3}"`

WC=`wc -l ${IN} | awk '{print $1}'`
seq 1 ${WC} > ${RAND}_seq.txt

for TAXA in $(cat ${RAND}_seq.txt); do
	COUNT=`head -${TAXA} ${IN} | tail -1 | cut -f 2- | tr '\t' '\n' | grep "^0$" | wc -l`
	KMER=`head -${TAXA} ${IN} | tail -1 | cut -f 1`
	echo "${KMER},${COUNT}" >> ${OUT}
done

# rm tmp files
rm ${RAND}_seq.txt		
