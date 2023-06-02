#!/bin/sh

while getopts p: flag
do
    case "${flag}" in
        p) projects=${OPTARG};;
    esac
done

python3 ~/$projects/m2snooty/m2snooty.py ~/$projects/cloud-docs/source/includes/sdk/go/markdown/concepts.txt
mv ~/$projects/cloud-docs/source/includes/sdk/go/markdown/concepts.rst ~/$projects/cloud-docs/source/sdk/go/concepts.txt
python3 ~/$projects/m2snooty/m2snooty.py ~/$projects/cloud-docs/source/includes/sdk/go/markdown/authentication.txt
mv ~/$projects/cloud-docs/source/includes/sdk/go/markdown/authentication.rst ~/$projects/cloud-docs/source/sdk/go/authentication.txt
python3 ~/$projects/m2snooty/m2snooty.py ~/$projects/cloud-docs/source/includes/sdk/go/markdown/error_handling.txt
mv ~/$projects/cloud-docs/source/includes/sdk/go/markdown/error_handling.rst ~/$projects/cloud-docs/source/sdk/go/error_handling.txt
python3 ~/$projects/m2snooty/m2snooty.py ~/$projects/cloud-docs/source/includes/sdk/go/markdown/migration.txt
mv ~/$projects/cloud-docs/source/includes/sdk/go/markdown/migration.rst ~/$projects/cloud-docs/source/sdk/go/migration.txt
python3 ~/$projects/m2snooty/m2snooty.py ~/$projects/cloud-docs/source/includes/sdk/go/markdown/reference.txt
mv ~/$projects/cloud-docs/source/includes/sdk/go/markdown/reference.rst ~/$projects/cloud-docs/source/sdk/go/reference.txt
