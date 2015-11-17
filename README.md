Package: read.folder

Title: Easily read whole folders using the read function of your choice.

Version: 0.0.1

Examples:
    read.folder("./path/to/folder/", read.function=fread)
    read.folder("./path/to/folder/", exclude="./path/to/folder/README.txt", recursive=TRUE, header=FALSE)