% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/compute_accession_coverage.R
\name{compute_num_peptides_per_1000aa}
\alias{compute_num_peptides_per_1000aa}
\title{Computing number of peptides per 1000 aa}
\usage{
compute_num_peptides_per_1000aa(msnid, path_to_FASTA)
}
\arguments{
\item{msnid}{(MSnID object) MS/MS ID data}

\item{path_to_FASTA}{(numeric) Maximum acceptable FDR rate. Default is 0.01.}
}
\value{
(MSnID object) MS/MS ID data with computed number of peptides per 1000 aa. Added column name - "peptides_per_1000aa".
}
\description{
Computing number of peptides per 1000 aa
}
\examples{
path_to_MSGF_results <- system.file("extdata/global/msgf_output", package = "PlexedPiperTestData")
msnid <- read_msgf_data(path_to_MSGF_results)
path_to_FASTA <- system.file("extdata/Rattus_norvegicus_NCBI_RefSeq_2018-04-10.fasta.gz", package = "PlexedPiperTestData")
msnid <- compute_num_peptides_per_1000aa(msnid, path_to_FASTA)
hist(msnid$peptides_per_1000aa)
}
