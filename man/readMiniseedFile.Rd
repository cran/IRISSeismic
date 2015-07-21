\name{readMiniseedFile}

\alias{readMiniseedFile}

\title{Convert miniSEED file to \code{Stream} object}

\description{
The \code{readMiniseedFile} function converts a raw miniSEED file into a \code{Stream}
object.
}

\usage{
readMiniseedFile(file,sensor,scale,scaleunits)
}

\arguments{
  \item{file}{character path of a miniSEED file}
  \item{sensor}{character description of the Sensor associated with this SNCL (see \link{Trace})}
  \item{scale}{character description of the InstrumentSensitivity associated with this SNCL (see \link{Trace})}
  \item{scaleunits}{character description of the InputUnits associated with this SNCL (see \link{Trace})}
}

\details{
This function reads in a raw miniSEED file and converts it to a \code{Stream} object.
}

\value{
A \code{Stream} object.}

%% \references{ }

\author{
Jonathan Callahan \email{jonathan.s.callahan@gmail.com}
}

%% \note{ }

%% ~Make other sections like Warning with \section{Warning }{....} ~

\seealso{
  \code{\link{miniseed2Stream}}
}

%% \examples{ }

