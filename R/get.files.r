#' This function returns the paths of all files a given folder
#'
#' @param folder.path The path of the folder 
#' @param recursive Search for files in subfolders. Defaults to FALSE
#' @return A list of file paths
#' @examples
#' get.files("./path/to/folder") 
get.files <- function(folder.path, recursive=FALSE) {
    all.files <- paste(folder.path, list.files(folder.path), sep='/')
    folders <- list.dirs(folder.path)
    folders <- setdiff(folders, folder.path)
    files <- all.files[file.info(all.files)$size > 0]
    if (recursive & length(folders) > 0) {
        for (folder in folders) {
            fls <- paste(folder, list.files(folder), sep='/')
            files <- fls[file.info(fls)$size > 0]
            files <- c(files, fls)
            }
        }
    return(files)
}    