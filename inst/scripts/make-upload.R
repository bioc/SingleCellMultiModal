# upload files to AWS S3
allextpat <- "\\.[Rr][Dd][AaSs]$|\\.[Mm][Tt][Xx]\\.[Gg][Zz]$|\\.[Hh]5$"

.version_folder <- function(version) {
        paste0("v", version)
}

.getDataFiles <- function(directory = "~/data/scmm",
    dataDir = "mouse_gastrulation", pattern = allextpat, version = "1.0.0"
) {
    vfolder <- .version_folder(version)
    location <- file.path(directory, dataDir, vfolder)
    list.files(
        location, pattern = pattern, full.names = TRUE, recursive = FALSE
    )
}

## check files are listed
.getDataFiles(dataDir = "pbmc_10x", version = "1.0.1")

# IMPORTANT!
# Make sure that AWS_DEFAULT_REGION, AWS_ACCESS_KEY_ID, and
# AWS_SECRET_ACCESS_KEY are set in the ~/.Renviron file

# source("inst/scripts/make-metadata.R")

upload_aws <- function(
    DataType, directory = "~/data/scmm", upload = FALSE,
    fileExt = allextpat, version = "1.0.0"
) {
    if (missing(DataType))
        stop("Enter a 'DataType' folder")
    datafilepaths <- .getDataFiles(
        directory = directory, dataDir = DataType,
        pattern = fileExt, version = version
    )
    vfolder <- .version_folder(version)
    bucketLocation <-
        file.path("experimenthub", "SingleCellMultiModal", DataType, vfolder)
    if (!upload)
        message("Data NOT uploaded")
    if (upload)
        AnnotationHubData:::upload_to_S3(file = datafilepaths,
            remotename = basename(datafilepaths),
            bucket = bucketLocation)
    else
        file.path("s3:/", bucketLocation, basename(datafilepaths))
}

# upload_aws(DataType = "mouse_gastrulation", version = "1.0.0", upload=TRUE)
# upload_aws(DataType = "mouse_gastrulation", version = "2.0.0", upload=TRUE)
# upload_aws(DataType = "cord_blood", directory="CITEseq", version = "1.0.0",
#     upload=TRUE)
# upload_aws(DataType = "mouse_visual_cortex", upload=TRUE)
# upload_aws(DataType = "pbmc_10x", directory = "~/data/scmm",
#     version = "1.0.0", upload = TRUE)
# upload_aws(DataType = "mouse_embryo_8_cell", directory = "~/data/scmm",
#     version = "1.0.0", upload = TRUE)
# upload_aws(DataType = "pbmc_10x", directory = "~/data/scmm",
#     version = "1.0.1", upload = TRUE)

