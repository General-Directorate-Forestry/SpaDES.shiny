% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/news.R
\name{appNewsUI}
\alias{appNewsUI}
\alias{appNews}
\title{Generate a page displaying your app's \file{NEWS} file}
\usage{
appNewsUI(id)

appNews(input, output, session, file = "NEWS.md", status = NULL)
}
\arguments{
\item{id}{An id string that corresponds with the id used to call the module's UI function.}

\item{input}{shiny server input object}

\item{output}{shiny server output object}

\item{session}{shiny server session object}

\item{file}{Path to a markdown file containing the NEWS (default: \code{"NEWS.md"}).}

\item{status}{The status (colour) of the box in which the \code{file} is rendered.
See \code{\link[shinydashboard]{box}}.}
}
\description{
Renders a markdown file containing your app's \file{NEWS} file, which can be used as
an updates feed for users to see what has changed in the app.
}
\author{
Alex Chubaty
}
