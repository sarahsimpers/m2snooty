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
  # take action on each file. $f store current file name
done

RSTFILES=~/$projects/cloud-docs/source/includes/sdk/go/markdown/*.rst
for f in $RSTFILES
do
  echo "Moving $f"
  mv $f ~/$projects/cloud-docs/source/sdk/go/
done

MOVEDRSTFILES=~/$projects/cloud-docs/source/sdk/go/*.rst
for f in $MOVEDRSTFILES
do  
  mv -- "$f" "${f%.rst}.txt"
done