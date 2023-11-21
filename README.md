

# m2Snooty

This is a markdown-to-Snooty-rST converter. It's adapted from [M2R](https://github.com/miyakogi/m2r), an archived Github repo, and adjusted to be specific to Snooty and the MongoDB documentation team's workflow.

To learn more about M2R, see [M2R's README](https://github.com/miyakogi/m2r#readme)

## Installation

Python 3.7+ is required.

1. Install the original m2r to get all dependencies for the program:

```
python3 -m pip install m2r
```

2. Clone this repo.
3. Follow the usage instructions below.

## Usage

There are two use cases for m2snooty:

### One-time conversion

You can use m2snooty to convert .md files to .rst files on a one-time basis and then manually move them to their destination repo.

#### Convert a single file

For one-time conversion of a single file, run the following command in the directory containing the markdown file. Replace `<your-repo-dir>` with the directory where you keep your Github repos and `file.md` with the name of the file.

```
python3 ~/<your-repo-dir>/m2snooty/m2snooty.py file.md
```

m2snooty converts your markdown file to rst and stores it in a file with an .rst extension. It places the .rst file in the same directory as the markdown file.

To use the file, change the .rst file extension to a .txt file extension and place it in the repo where you want to build the page with Snooty.

#### Convert multiple files

You can convert multiple files in a directory and change their file extension to `.txt` by running the [migrator script](https://github.com/sarahsimpers/m2snooty/blob/main/scripts/m2snooty-migrator.sh). To run the migrator script:

1. Navigate to the directory that contains the files you want to convert to .rst.
2. Run the following command. Replace `<your-repo-dir>` with the directory where you keep your Github repos:

```
sh ~/<your-repo-dir>/m2snooty/scripts/m2snooty-migrator.sh -p <your-repo-dir>
```

m2snooty converts your markdown files to rst and changes their file extensions to `.txt`. It places the .txt files in the same directory as the markdown file. To write the results to another location, adjust the [migrator script](https://github.com/sarahsimpers/m2snooty/blob/main/scripts/m2snooty-migrator.sh) and run the adjusted version.

### Ongoing conversion

You can use m2snooty together with [docurl](https://github.com/mongodb/docs-docurl) for ongoing conversion. This is ideal when you need to maintain a Github repo containing markdown docs, but you also want an up-to-date copy of those docs rendered with Snooty in a MongoDB docs site. To do this, set up docurl to continuously pull .md files into a directory that you add to .gitignore (to prevent Snooty errors). Then, keep the Snooty versions updated by running `docurl fetch` and running a script (like [this one for the cloud docs team](https://github.com/sarahsimpers/m2snooty/blob/main/scripts/m2snooty-atlas-go-sdk.sh)) to quickly run m2snooty.py, move the rST files to a folder that Git tracks, and change them to .txt files.

To run the script for the cloud docs team, writers run `sh ~/Projects/m2snooty/scripts/m2snooty-atlas-go-sdk.sh -p Projects` and replace both instances of `Projects` with the directory that houses their repos.
