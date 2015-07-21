\name{TraceHeader-class}
\Rdversion{1.1}
\docType{class}
\alias{TraceHeader-class}
\alias{TraceHeader}
\alias{as.headerLine,TraceHeader-method}
\alias{as.headerLine}
\alias{initialize,TraceHeader-method}
\alias{show,TraceHeader-method}

%% NOTE:  the following lines suppress warning messages from R CMD check but clutter up the index

%%\alias{as.headerLine,TraceHeader-method}
%%\alias{show,TraceHeader-method}


\title{ Class \code{"TraceHeader"} }

\description{
A container for metadata associated with a \code{Trace} object.
}
\section{Objects from the Class}{
Objects can be created by calls of the form \code{new("TraceHeader", headerList, headerLine, ...)}.
The \code{stats} slot of a \code{Trace} object will contain a \code{TraceHeader} object,
typically populated by a webservice request. (see \link{IrisClient-class})
}

\section{Slots}{
  \describe{
    \item{\code{sampling_rate}:}{Object of class \code{"numeric"}: Sampling rate in hertz.}
    \item{\code{delta}:}{Object of class \code{"numeric"}: Sample distance in seconds.}
    \item{\code{calib}:}{Object of class \code{"numeric"}: Calibration factor.}
    \item{\code{npts}:}{Object of class \code{"integer"}: Number of sample points.}
    \item{\code{network}:}{Object of class \code{"character"}: Seismic network name.}
    \item{\code{location}:}{Object of class \code{"character"}: Location code.}
    \item{\code{station}:}{Object of class \code{"character"}: Station name.}
    \item{\code{channel}:}{Object of class \code{"character"}: Channel code.}
    \item{\code{quality}:}{Object of class \code{"character"} Data quality code}
    \item{\code{starttime}:}{Object of class \code{"POSIXct"}: Start time.}
    \item{\code{endtime}:}{Object of class \code{"POSIXct"}: End time.}
    \item{\code{processing}:}{Object of class \code{"list"}: Information strings describing processing applied to this trace. }
  }
}

\section{Methods}{
  \describe{
    \item{as.headerLine}{\code{signature(obj = "TraceHeader")}: 
    Prints out the information in the \code{TraceHeader} as an ascii header line, e.g.
    \preformatted{
    TIMESERIES LD_POTS__HHZ_M, 351 samples, 100.503 sps, \
    2012-01-29T00:00:00.006000, SLIST, INTEGER, COUNTS}}
    %%\item{initialize}{\code{signature(.Object = "TraceHeader")}: \strong{NOT YET WRITTEN} }
    \item{show}{\code{signature(object = "TraceHeader")}: Prettyprints the information in the \code{TraceHeader} }
	 }
}

%% \references{ }

\author{
Jonathan Callahan \email{jonathan.s.callahan@gmail.com}
}

\note{
The \code{TraceHeader} object is inspired by the \code{Stats} class found in the
python ObsPy package (\url{http://docs.obspy.org/packages/autogen/obspy.core.trace.Stats.html}).

Retaining the ObsPy class name \code{Stats} would have generated a tremendous amount of 
confusion in the context of R. Instead, the name
\code{TraceHeader} has been adopted. Nevertheless, the \code{TraceHeader} object still lives in the 
\code{Trace@stats} slot to retain as much similarity to ObsPy as possible.
}

%% ~Make other sections like Warning with \section{Warning }{....} ~

%% \seealso{ }

\examples{
# Open a connection to IRIS DMC webservices
iris <- new("IrisClient")

starttime <- as.POSIXct("2012-01-24", tz="GMT")
endtime <- as.POSIXct("2012-01-25", tz="GMT")

# Get the waveform
st <- getDataselect(iris,"AK","PIN","","VEA",starttime,endtime)

# Get the first trace and show the associated metadata
tr1 <- st@traces[[1]]
show(tr1@stats)
}

\keyword{classes}
