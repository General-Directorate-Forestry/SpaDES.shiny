% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/slicer.R
\name{getSubtable}
\alias{getSubtable}
\alias{getSubtableMem}
\title{Get subtable from a \code{data.table}}
\usage{
getSubtable(datatable, chosenCategories, chosenValues)

getSubtableMem(datatable, chosenCategories, chosenValues)
}
\arguments{
\item{datatable}{A \code{data.table} object.}

\item{chosenCategories}{...}

\item{chosenValues}{...}
}
\value{
A \code{data.table} object.
}
\description{
\code{getSubtableMem} provides a memoised version of \code{getSubtable}.
}
