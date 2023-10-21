#!/bin/sh
mkdir -p /tmp/pdfextract
echo "pdfseparate $1 /tmp/pdfextract/$1.part%d"
pdfseparate $1 "/tmp/pdfextract/$1.part%d"

command="pdfunite "
for i in {$3..$4}; do
    command+="/tmp/pdfextract/$1.part$i "
    echo "Number: $i"
done
command+=" $2"
echo $command
eval $command
