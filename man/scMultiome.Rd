% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/scMultiome.R
\name{scMultiome}
\alias{scMultiome}
\title{Single-cell Multiome ATAC + Gene Expression}
\usage{
scMultiome(
  DataType = "pbmc_10x",
  modes = "*",
  version = "1.0.0",
  format = c("MTX", "HDF5"),
  dry.run = TRUE,
  verbose = TRUE,
  ...
)
}
\arguments{
\item{DataType}{character(1) Indicates study that produces this type of
data (default: 'mouse_gastrulation')}

\item{modes}{character() A wildcard / glob pattern of modes, such as
\code{"acc*"}. A wildcard of \code{"*"} will return all modes including
Chromatin Accessibilty ("acc"), Methylation ("met"), RNA-seq ("rna")
which is the default.}

\item{version}{character(1) Either version '1.0.0' or '2.0.0' depending on
data version required (default '1.0.0'). See version section.}

\item{format}{Either MTX or HDF5 data format (default MTX)}

\item{dry.run}{logical(1) Whether to return the dataset names before actual
download (default TRUE)}

\item{verbose}{logical(1) Whether to show the dataset currently being
(down)loaded (default TRUE)}

\item{...}{Additional arguments passed on to the
\link[ExperimentHub]{ExperimentHub-class} constructor}
}
\value{
A 10X PBMC \code{MultiAssayExperiment} object
}
\description{
10x Genomics Multiome technology enables simultaneous profiling
of the transcriptome (using 3’ gene expression) and epigenome
(using ATAC-seq) from single cells to
deepen our understanding of how genes are expressed and regulated across
different cell types. Data prepared by Ricard Argelaguet.
}
\details{
Users are able to choose from either an \code{MTX} or \code{HDF5} file format
as the internal data representation. The \code{MTX} (Matrix Market)
format allows users to load a sparse \code{dgCMatrix} representation.
Choosing \code{HDF5} gives users a sparse \code{HDF5Array} class object.
\itemize{pbmc_10x:} 10K Peripheral Blood Mononuclear Cells provided by
\href{https://support.10xgenomics.com/single-cell-multiome-atac-gex/datasets}{10x Genomics website}
Cell quality control filters are available in the object \code{colData}
together with the \code{celltype} annotation labels.
}
\examples{

scMultiome(DataType = "pbmc_10x", modes = "*", dry.run = TRUE)

}
