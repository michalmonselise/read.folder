#' Reads an entire folder using the read function of your choice
#'
#' @param folder.path The path of the folder
#' @param read.function The function used to read the files. Do not surround in quotes. Deafults to read.csv
#' @param recursive Whether we should look inside subfolders. Defaults to FALSE
#' @param exclude Paths of all files we would like to exclude from reading (for example README files)
#' @return This function returns the object (data.frame, data.table, etc) of your choice containing data from all files in the specified folder
#' @examples
#' read.folder("./path/to/folder/", read.function=fread)
#' read.folder("./path/to/folder/", exclude="./path/to/folder/README.txt", recursive=TRUE, header=FALSE)
read.folder <- function(folder.path, read.function=read.csv, recursive=FALSE, exclude = NULL, ...) {
    file.list <- get.files(folder.path, recursive)
    if (!is.null(exclude)) {
        file.list <- file.list[!grepl(exclude, file.list)]
    }
    read.files(file.list, read.function, ...)
   
   }
   
#' This function reads a list of folders using the read function of your choice
#'
#' @param file.list A list of file paths
#' @param read.function A read function. Does not have a default. Possible suggestions are read.csv, read.table, fread, etc
#' @return This function returns the object (data.frame, data.table, etc) of your choice containing data from all files specified
#' @examples
#' read.files(c("file1.csv", "file2.csv", read.function=read.table, col.names=c("a","b","c"), colClasses=c("character","character","numeric"))
read.files <- function(file.list, read.function, ...) {   
    if (length(file.list) < 1) {stop("There are no files in the folder")}
    output <- read.function(file.list[1], ...)
    if (length(file.list) > 1) {
        for (f in file.list[-1]) {
            tmp <- read.function(f, ...)
            if (!identical(names(output), names(tmp))) {stop("The files do not have the same schema. If you are using read.csv, remember that a header column is a default")}
            output <- rbind(output,tmp)
            rm(tmp)
            }
        }
    return(output)
    }
    

