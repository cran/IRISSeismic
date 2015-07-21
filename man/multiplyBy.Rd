\name{multiplyBy}
\docType{methods}
\alias{multiplyBy}
\alias{multiplyBy,Stream,numeric-method}
\alias{multiplyBy,Trace,numeric-method}

\title{Multiplication by a constant}

\description{
The \code{multiplyBy} methods of \code{Trace} and \code{Stream} objects return like objects
where all \code{@data} slots have been multiplied by a constant.
}

\usage{
multiplyBy(x, y)
}

\arguments{
  \item{x}{
a \code{Trace} or \code{Stream} object
  }
  \item{y}{
a numeric multiplier
  }
}

%% \details{ }

\value{
A new \code{Trace} or \code{Stream} object is returned.
}

%% \references{ }

\author{
Jonathan Callahan \email{jonathan.s.callahan@gmail.com}
}

%% \note{ }

%% \seealso{ }

\examples{
# Open a connection to IRIS DMC webservices
iris <- new("IrisClient")

starttime <- as.POSIXct("2012-01-24", tz="GMT")
endtime <- as.POSIXct("2012-01-25", tz="GMT")

# Get the waveform
stRaw <- getDataselect(iris,"AK","PIN","","VEA",starttime,endtime)

# obtain an instrument sensitivity value with getChannelMetadata)
# ...

sensitivityValue <- 10.0

# convert raw data
st <- multiplyBy(stRaw, sensitivityValue)

rmsVariance(st)
}

\keyword{methods}
