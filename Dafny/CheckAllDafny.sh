#!/bin/bash

touch output.txt

lFiles=("Blood"
        "BloodInventory"
        "Filtering"
        #"MergeSort"
        "QueryBloodInventory"
        "Request"
        "Searching"
        "SortBloodInventory"
        "Test")

echo "Checking all Dafny files"
for i in "${!lFiles[@]}"
do
    echo "----------------------------------------------------------------" >> output.txt
    printf "%s \e[1;33m%-20s\e[0m" "($((i+1))/${#lFiles[@]})" "${lFiles[i]}"
    echo "Running ${lFiles[i]}.dfy" >> output.txt
    echo "" >> output.txt
    t=$({ TIMEFORMAT="%1U"; time dafny /compile:3 ${lFiles[i]}.dfy >> output.txt; } 2>&1)
    if [ $? -eq 0 ]; then
        printf -- "- \e[1;32mOK\e[0m (${t}s)\n"
    else
        printf -- "- \e[1;31merrors\e[0m\n"
    fi
    echo "" >> output.txt
done
