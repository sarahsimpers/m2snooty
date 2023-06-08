#!/bin/sh

while getopts p: flag
do
    case "${flag}" in
        p) projects=${OPTARG};;
    esac
done

for f in $(find . -name '*.md' -type f -print)
do  
  echo "Changing title for $f..."
  sed -i '' "s%---% %g" $f
  sed -i '' "s%title:%#%g" $f
done

for f in $(find . -name '*.md' -type f -print)
do
  echo "Transforming $f to Snooty-friendly rST..."
  python3 ~/$projects/m2snooty/m2snooty.py $f
done

for f in $(find . -name '*.rst' -type f -print)
do  
  echo "Changing extension to txt for $f..."
  mv -- "$f" "${f%.rst}.txt"
done