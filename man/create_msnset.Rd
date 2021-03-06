% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/create_msnset.R
\name{create_msnset}
\alias{create_msnset}
\title{Makes MSnSet from Quantitative Crosstab.}
\usage{
create_msnset(crosstab, samples)
}
\arguments{
\item{samples}{(table) matches sample names to reporter ions}
}
\value{
(MSnSet object) with log2-transformed relative reporter ion intensities as expression
data and the samples table as phenotype data.
}
\description{
Creates MSnSet object from quantitative crosstab and attached phenotype data.
}
\examples{

# Prepare MS/MS IDs
path_to_MSGF_results <- system.file("extdata/global/msgf_output", package = "PlexedPiperTestData")
msnid <- read_msgf_data(path_to_MSGF_results)
msnid <- MSnID::correct_peak_selection(msnid)
show(msnid)
msnid <- filter_msgf_data_peptide_level(msnid, 0.01)
show(msnid)
path_to_FASTA <- system.file("extdata/Rattus_norvegicus_NCBI_RefSeq_2018-04-10.fasta.gz", package = "PlexedPiperTestData")
msnid <- compute_num_peptides_per_1000aa(msnid, path_to_FASTA)
msnid <- filter_msgf_data_protein_level(msnid, 0.01)
show(msnid)

# Prepare table with reporter ion intensities
path_to_MASIC_results <- system.file("extdata/global/masic_output", package = "PlexedPiperTestData")
masic_data <- read_masic_data(path_to_MASIC_results, interference_score=TRUE)
masic_data <- filter_masic_data(masic_data, 0.5, 0)

# Creating cross-tab
library(readr)
fractions <- read_tsv(system.file("extdata/study_design/fractions.txt", package = "PlexedPiperTestData"))
samples <- read_tsv(system.file("extdata/study_design/samples.txt", package = "PlexedPiperTestData"))
references <- read_tsv(system.file("extdata/study_design/references.txt", package = "PlexedPiperTestData"))
aggregation_level <- c("accession")

crosstab <- create_crosstab(msnid, masic_data, aggregation_level, fractions, samples, references)
m <- create_msnset(crosstab, samples)
dim(m)
head(exprs(m))
}
