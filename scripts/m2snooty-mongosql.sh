#!/bin/sh

while getopts p: flag
do
    case "${flag}" in
        p) projects=${OPTARG};;
    esac
done

FILES=~/$projects/cloud-docs/source/includes/mongosql/markdown/*
for f in $FILES
do
  echo "Transforming $f to Snooty-friendly rST..."
  python3 ~/$projects/m2snooty/m2snooty.py $f
done

RSTFILEURLS=~/$projects/cloud-docs/source/includes/mongosql/markdown/*.rst
for f in $RSTFILEURLS
do  
  echo "Changing file names and adding notes/refs in $f..."

  filename="${f##*/}"
  sed -i '' "1s%^%\n.. _mongosql-${filename%.rst}: \n%" $f

  sed -i '' "1s%^%.. NOTE TO WRITERS: Don't edit these files. Docurl pulls the content in automatically from the 10gen\/mongosql-rs repo. To make copy edits, change the source files here: https:\/\/github.com\/10gen\/mongosql-rs\/tree\/master. For rST issues, open a Jira ticket and assign it to Sarah Simpers. \n%" $f

done

RSTFILES=~/$projects/cloud-docs/source/includes/mongosql/markdown/*.rst
for f in $RSTFILES
do
  echo "Moving $f..."
  mv $f ~/$projects/cloud-docs/source/data-federation/query/sql/
done

MOVEDRSTFILES=~/$projects/cloud-docs/source/data-federation/query/sql/*.rst
for f in $MOVEDRSTFILES
do  
  mv -- "$f" "${f%.rst}.txt"
done