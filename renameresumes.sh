#!/bin/bash
#**********************************************************
#*  Script to rename list of pdfs based on id stored      *
#*  in mySQL database.                                    *
#*                                                        *
#*  Contributors: Darshan Thaker, Gilad Oved              *
#*  Date: September 23, 2015                              *
#**********************************************************

#Put the output of rows in an array
rows=($(ls -a tmp/ | sort -h | sed -e 's/\..*$//'))
array=${rows[@]}
length=${#rows[@]}
str=$(printf ",%s" $array)
str=${str:1} 

#Write that output of rows to batch_file
echo	"SELECT CONCAT(***, '_', ****) 
		FROM ****
		WHERE id in ($str)
		ORDER BY id;" > batch_file

#Run mysql command with batch_file input
output=($(mysql -u ****** -pPassword ****** 2>/dev/null < batch_file | tail -n $length | sed 's/ /-/g'))

#Rename files in /tmp to new $output values.
counter=0
for i in $array; do
    #echo $i
    cp tmp/$i.pdf RESULT/
    mv RESULT/$i.pdf RESULT/${output[$counter]}.pdf
    ((counter++))
done
