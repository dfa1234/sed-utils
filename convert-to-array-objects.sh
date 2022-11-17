#!/bin/bash

if [ $# -lt 1 ]; then
    echo "please provide file in input"
    exit 1
fi

currentDir=$(pwd)
fileName=$1

fileIn="$currentDir/$fileName"
fileOut="$fileIn-result.ts"

temp=$(sed 's/^/{/' $fileIn)
comp=$(echo "$temp"  | sed 's/$/},/')
echo "export const array = [$comp]" > $fileOut

echo $fileOut
echo "Done."