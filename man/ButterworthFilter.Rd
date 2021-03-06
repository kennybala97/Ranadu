% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/ButterworthFilter.R
\name{ButterworthFilter}
\alias{ButterworthFilter}
\title{ButterworthFilter}
\usage{
ButterworthFilter(x, tau = 200)
}
\arguments{
\item{x}{A numeric vector giving the elements in the series}

\item{tau}{A numeric that determines the time constant of the filter, in units of the steps in the input time series.}
}
\value{
The filtered numeric series
}
\description{
Applies a low-pass Butterworth filter recursively
}
\details{
See the description in"ProcessingAlgorithms.pdf". Do not use this function;
it is for testing historical processing of RAF data files, but there is an error that
causes an offset in the filtered values. Use signal::butter instead. 
Missing values are skipped in the recursive filter and are replicated in the output.
}
\examples{
\dontrun{xf <- ButterworthFilter (x, tau)}
}
\author{
William Cooper
}
