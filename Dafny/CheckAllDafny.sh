#!/bin/sh

touch output.txt

listOfFiles=("Blood"
			 "BloodInventory"
			 "Request"
			 "Filtering"
			 #"MergeSort"
			 "Query"
			 "Searching"
			 "SortBloodInventory"
			 "Test")

for i in "${listOfFiles[@]}"
do
	echo "---------------------------------------------------------" >> output.txt
	echo "running $i.dfy" >> output.txt
	echo " " >> output.txt
	dafny /compile:3 $i.dfy >> output.txt
	echo " " >> output.txt
	echo " " >> output.txt
done