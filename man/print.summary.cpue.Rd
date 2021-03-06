% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/cpue-class.R
\name{print.summary.cpue}
\alias{print.summary.cpue}
\title{Print method for summary.cpue}
\usage{
\method{print}{summary.cpue}(x, language = "spanish")
}
\arguments{
\item{x}{Object of \code{summary.cpue} class.}

\item{language}{The select language to print the summary of cpue objects.
It could be \code{"spanish"} by default or \code{"english"}.}
}
\value{
Each element of \code{summary.cpue} method.
}
\description{
Shows main information from \code{summary.cpue} objects.
}
\examples{
# Read a example of a data base
fisheryData = system.file("extdata", "fisheryData.csv", package = "imarpe")

# Produce a object of cpue class
cpue  = getFishingData(file = fisheryData, type = "cpue", varType = "cpue", sp = "caballa", efforType = "capacidad_bodega")
class(cpue)

# Print the summary of the cpue class object
sumCpue = summary(effort)
print(sumCpue)

sumCpue = summary(effort, language = "english")
print(sumCpue, language = "english")

}
