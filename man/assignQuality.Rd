\name{assignQuality}
\docType{methods}
\alias{assignQuality}
\alias{assignQuality,Stream,character-method}
\alias{assignQuality,Trace,character-method}

\title{Assign a quality code to a \code{Stream} or \code{Trace}}

\description{
The \code{assignQuality} methods of \code{Stream} and \code{Trace} objects return like objects
that modify the quality code in the @id slot.
}

\usage{
assignQuality(x, quality)
}

\arguments{
  \item{x}{ a \code{Trace} or \code{Stream} object}
  \item{quality}{ quality code, one of "R", "D", "Q", "M" }
}

\details{
The returned object will have a modified @id slot, where the last character is
replaced by \code{quality}.
}

\value{
A new \code{Trace} or \code{Stream} object is returned.
}

%% \references{ }

\author{
Gillian Sharer \email{gillian.sharer@earthscope.org}
}

\keyword{methods}
