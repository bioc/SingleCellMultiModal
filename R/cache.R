.getCache <- function() {
    cache <- getOption("scmmCache", setCache(verbose = FALSE))
    BiocFileCache::BiocFileCache(cache)
}

#' @name scmmCache 
#'
#' @title Manage cache / download directories for study data
#'
#' @description Managing data downloads is important to save disk space and
#' re-downloading data files. This can be done effortlessly via the integrated
#' `BiocFileCache` system.
#'
#' @section scmmCache:
#' Get the directory location of the cache. It will prompt the user to create
#' a cache if not already created. A specific directory can be used via
#' \code{setCache}.
#'
#' @section setCache:
#' Specify the directory location of the data cache. By default, it will
#' got to the user's home/.cache and "appname" directory as specified by
#' \link{user_cache_dir}. (default appname: 'SingleCellMultiModal')
#'
#' @section removeCache:
#' Some files may become corrupt when downloading, this function allows
#' the user to delete the tarball associated with a study number in the
#' cache.
#'
#' @param directory The file location where the cache is located. Once set
#' future downloads will go to this folder.
#' 
#' @param verbose Whether to print descriptive messages
#' 
#' @param ask logical (default TRUE when interactive session) Confirm the file
#' location of the cache directory
#' 
#' @param cancer_study_id A single string from `studiesTable` associated
#' with a study tarball
#' 
#' @param ... For `scmmCache`, arguments passed to `setCache`
#'
#' @md
#'
#' @export
scmmCache <- function(...) {
    getOption("scmmCache", setCache(..., verbose = FALSE))
}

#' @rdname scmmCache
#' @export
setCache <-
    function(directory = rappdirs::user_cache_dir("SingleCellMultiModal"),
        verbose = TRUE,
        ask = interactive())
{
    stopifnot(is.character(directory),
        isSingleString(directory), !is.na(directory))

    if (!dir.exists(directory)) {
        if (ask) {
            qtxt <- sprintf(
                "Create cBioPortalData cache at \n    %s? [y/n]: ",
                directory
            )
            answer <- .getAnswer(qtxt, allowed = c("y", "Y", "n", "N"))
            if ("n" == answer)
                stop("'cbioCache' directory not created. Use 'setCache'")
        }
        dir.create(directory, recursive = TRUE, showWarnings = FALSE)
    }
    options("cbioCache" = directory)

    if (verbose)
        message("cBioPortalData cache directory set to:\n    ",
                directory)
    invisible(directory)
}

#' @rdname scmmCache
#' @export
removeCache <- function(accession) {
    bfc <- .getCache()
    rid <- bfcquery(bfc, cancer_study_id, "rname", exact = TRUE)$rid
    if (length(rid)) {
        bfcremove(bfc, rid)
        message("Cache record: ", accession, ".tar.gz removed")
    } else
        message("No record found: ", accession, ".tar.gz")
}