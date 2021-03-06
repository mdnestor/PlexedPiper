% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/create_crosstab.R
\name{create_crosstab}
\alias{create_crosstab}
\title{Makes Cross-Tab With Quantitative Data.}
\usage{
create_crosstab(
  msnid,
  reporter_intensities,
  aggregation_level,
  fractions,
  samples,
  references
)
}
\arguments{
\item{msnid}{(MSnID object) filtered MS/MS identifications}

\item{reporter_intensities}{(data.frame) collated table with filtered reporter
intensities.}

\item{aggregation_level}{(string vector) defines what intensities needs to be aggregated.
At this point the only aggregation function is `sum`.
Typically intensities from different fractions of the same plex are aggregated.
Also e.g. in global proteomics intensities from different scans identifiying peptides
from the same protein aggregated togeher too.}
}
\value{
(matrix) with log2-transformed relative reporter ion intensities.
Row names are the names of the measured species.
Column names are the names of the samples.
}
\description{
Links filtered MS/MS IDs with reporter intensities. Divides reporter ion
intensities by corresponding reference and then returns cross-tab. Rows are
species (e.g. proteins in global, phosphopeptides in phosphoproteomic experiment),
columns are sample names.
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
masic_data <- read_masic_data(path_to_MASIC_results, extra_metrics=TRUE)
masic_data <- filter_masic_data(masic_data, 0.5, 0)

# Creating cross-tab
library(readr)
fractions <- read_tsv(system.file("extdata/study_design/fractions.txt", package = "PlexedPiperTestData"))
samples <- read_tsv(system.file("extdata/study_design/samples.txt", package = "PlexedPiperTestData"))
references <- read_tsv(system.file("extdata/study_design/references.txt", package = "PlexedPiperTestData"))
aggregation_level <- c("PlexID","accession")

out <- create_crosstab(msnid, masic_data, aggregation_level, fractions, samples, references)
dim(out)
head(out)
}
