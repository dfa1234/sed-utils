#!/bin/bash

if [ $# -lt 1 ]; then
    echo "please provide item directory in input - in snake/spinal case"
    exit 1
fi
if [ $# -lt 2 ]; then
    echo "please provide item directory for output - in snake/spinal case"
    exit 1
fi

currentDir=$(pwd)

itemIn=$1
itemPathIn=${currentDir}/$itemIn

if [ -d "$itemPathIn" ];
then
    echo "Found input directory item: $itemPathIn"
else
    echo "$itemPathIn directory does not exist."
    exit 1
fi

itemOut=$2
itemPathOut=${currentDir}/$itemOut

if [ -d "$itemPathOut" ];
then
    echo "Found output item directory: $itemPathOut"
    echo "Output directory already exists, please check manually first."
    echo "Remove command if needed: rm -rf $itemPathOut"
    exit 1
else
    echo "Duplicating item '$itemIn' to '$itemOut'"
fi

find $itemPathIn -type d | while read FILE ; do
    newfile=$(echo ${FILE} | sed -e "s/${itemIn}/${itemOut}/g");
    mkdir "${newfile}" ;
done

find $itemPathIn -type f | while read FILE ; do
    newfile=$(echo ${FILE} | sed -e "s/${itemIn}/${itemOut}/g");
    cp "${FILE}" "${newfile}";
done

# snake case
find $itemPathOut -type f -exec sed -i -e "s/${itemIn}/${itemOut}/g" {} \;

# capitalize
find $itemPathOut -type f -exec sed -i -e "s/${itemIn^}/${itemOut^}/g" {} \;

# uppercase
find $itemPathOut -type f -exec sed -i -e "s/${itemIn^^}/${itemOut^^}/g" {} \;

# camel case
itemInCamel=$(sed -r 's/(^|-)(\w)/\U\2/g' <<< $itemIn)
itemOutCamel=$(sed -r 's/(^|-)(\w)/\U\2/g' <<< $itemOut)
find $itemPathOut -type f -exec sed -i -e "s/${itemInCamel}/${itemOutCamel}/g" {} \;

ls -laR $itemPathOut
echo ""
echo "Done: ${itemPathOut}"