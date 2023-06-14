#!/bin/sh

while getopts p: flag
do
    case "${flag}" in
        p) projects=${OPTARG};;
    esac
done

FILES=~/$projects/cloud-docs/source/includes/sdk/go/markdown/*
for f in $FILES
do
  echo "Transforming $f to Snooty-friendly rST..."
  python3 ~/$projects/m2snooty/m2snooty.py $f
done

RSTFILEURLS=~/$projects/cloud-docs/source/includes/sdk/go/markdown/*.rst
for f in $RSTFILEURLS
do  
  echo "Changing hardcoded URLs and adding notes/refs in $f..."

  filename="${f##*/}"
  sed -i '' "1s%^%\n.. _atlas-sdk-${filename%.rst}: \n%" $f

  sed -i '' "s%\`Error Handling <https:\/\/github.com\/mongodb\/atlas-sdk-go\/blob\/main\/docs\/doc_2_error_handling.md>\`__%:ref:\`atlas-sdk-error_handling\`%g" $f

  sed -i '' "s%\`Authenticate using the Atlas Go SDK <https:\/\/github.com\/mongodb\/atlas-sdk-go\/blob\/main\/docs\/doc_4_authentication.md>\`__%:ref:\`atlas-sdk-authentication\`%g" $f

  sed -i '' "1s%^%.. NOTE TO WRITERS: Don't edit these files. Docurl pulls the content in automatically from the mongodb\/atlas-sdk-go repo. To make copy edits, change the source files here: https:\/\/github.com\/mongodb\/atlas-sdk-go\/tree\/main\/docs. For rST issues, open a Jira ticket and assign it to Sarah Simpers. \n%" $f

done

RSTFILES=~/$projects/cloud-docs/source/includes/sdk/go/markdown/*.rst
for f in $RSTFILES
do
  echo "Moving $f..."
  mv $f ~/$projects/cloud-docs/source/sdk/go/
done

MOVEDRSTFILES=~/$projects/cloud-docs/source/sdk/go/*.rst
for f in $MOVEDRSTFILES
do  
  mv -- "$f" "${f%.rst}.txt"
done