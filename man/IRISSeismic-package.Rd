\docType{package}
\name{IRISSeismic-package}
\alias{IRISSeismic-package}
\alias{IRISSeismic}

\title{Classes and methods for seismic data analysis}

\description{
This package provides S4 classes for downloading and processing seismological 
data available from the IRIS Data Management Center (DMC) (\url{http://www.iris.edu/dms/nodes/dmc/}).
Core classes \code{Trace}, \code{Stream} and \code{IrisClient} and their associated methods
are inspired by the functionality available in the python ObsPy package (\url{http://obspy.org/}).
}

\section{Introduction}{
  The "IRISSeismic-intro" vignette gives introductory examples on using the package.
}

\author{
Jonathan Callahan \email{jonathan.s.callahan@gmail.com}
}

\references{
ObsPy: \url{http://obspy.org/}

IRIS DMC web services: \url{http://service.iris.edu/}
}

\section{History}{

  version 1.0.6 -- CRAN updates required
  \itemize{
    \item{Removed "mode" argument form Trace.as.vector() signature.}
  }

  version 1.0.4 -- name change to IRISSeismic
  \itemize{
    \item{Name change required because 'seismic' was recently taken.}
    \item{Using explicit references for 'utils' and 'stats' package functions as this is now required for CRAN.}
  }

  version 1.0.3 -- cleanup for submission to CRAN
  \itemize{
    \item{Updated libmseed to version 2.16}
  }

  version 0.2.8.0 -- minor tweaks to 0.2.7
  \itemize{
    \item{Updated links to IRIS web services in the documentation.}
    \item{McNamaraBins() ignores bin #0 (~= DC)}
    \item{McNamaraPSD() conversion to dB occurs \strong{after} binning, not before}
  }

  version 0.2.7.0 -- hilbert transform
  \itemize{
    \item{New hilbertFFT() function.}
    \item{New hilbert() trace method.}
  }
  
  version 0.2.6.0 -- cross correlation
  \itemize{
    \item{Added surfaceDistance() function.}
    \item{Added rotate2D() function.}
  }
  
  version 0.2.5.0 -- channel orientation
  \itemize{
    \item{Jumping to version 0.2.5 to match project milestone names.}
    \item{Added getSNCL() convenience wrapper for getDataselect() method.}
    \item{Added getDistaz() method of IrisClient.}
    \item{Added miniseed2Stream() and readMiniseedFile() functions.}
    \item{Added getRotation() method of IrisClient.}
  }
  
  version 0.2.3.0 -- cross spectrum
  \itemize{
    \item{Moved McNamaraPSD() from trace method to spectral utility function.}
    \item{Added spectral utility functions:
    \itemize{
      \item{crossSpectrum()}
      \item{McNamaraBins()}
    }
    }
    \item{All get~ methods that return dataframes now guarantee a default ordering of rows.}
  }
  
  version 0.2.2.0 -- PSD and friends
  \itemize{
    \item{Add dependency on pracma package.}
    \item{Use pracma::detrend() function in DDT.Trace().}
    \item{Added "increment" parameter to STALTA.Trace().}
    \item{Removed STALTA.Trace() algorithm "classic_LR2".}
    \item{Fixed URL generation for getEvalresp() when location="".}
    \item{Added NamaraPSD.Trace() method.}
    \item{Added PSD/PDF utility functions:
    \itemize{
      \item{noiseMatrix2PdfMatrix()}
      \item{noiseModels()}
      \item{psdDF2NoiseMatrix()}
      \item{psdList()}
      \item{psdList2NoiseMatrix()}
      \item{psdStatistics()}
      \item{psdPlot()}
    }
    }
  }
    
  version 0.2.1.1 -- Bug fix release
  \itemize{
    \item{Removed dependcy on signal, XML packages.}
  }
    
  version 0.2.1.0 -- FDSN web services
  \itemize{
    \item{Conversion to FDSN web services including the following new/rewritten methods:
    \code{getNetwork}, \code{getStation}, \code{getChannel}, \code{getAvailability}, \code{getUnavailability}}
    \item{Updated version of \code{getEvent} to return a dataframe with columns named "latitude" and "longitude"
    for consistency with all other web services}
    \item{Updated documentation and Rscripts to match the API changes in the conversion to FDSN web services.}
    \item{Removal of all \code{StationXML} classes in favor of storing that information in slots of the \code{Trace} class.}
    \item{Updates to \code{Trace} object slots \code{@Sensor}, \code{@InstrumentSensitivity} and \code{@InputUnits}
    to store information as \code{character}, \code{numeric} and \code{character} instead of \code{StationXML} classes.}
    \item{The \code{TraceHeader@quality} slot now reflects the data quality returned in the miniSEED record
    rather than the quality that was requested by getDataselect. (Requests with \code{quality=B} for "Best" typically return
    \code{quality=M}.)}
    \item{Improved \code{STALTA.Trace()} method removes experimental algorithms and now uses C++ code from package 
    \code{rollSeismic} to calculate rolling means.}
    \item{Updated \code{IrisClient} now uses web services from \url{http://service.iris.edu} for the following methods:
    \code{getDataselect}, \code{getEvalresp}, \code{getEvent}}
  }
  
  version 0.2.0.0
  \itemize{
    \item{Removed PSD methods of \code{Stream} and \code{Trace}. PSD algorithms are now part of the PSD metric.}
    \item{Improved \code{mergeTraces.Stream()} method now accepts \code{fillMethod="fillZero"}.}
  }
  
  version 0.1.9.0 
  \itemize{
    \item{New \pkg{rollSeismic} package for fast rolling algorithms implemented in C++/Rcpp.}
    \item{New \code{num_spikes} metric based on \code{seismicRoll::roll_hampel} outlier detection.}
    \item{New \code{correlation} metric.}
    \item{New scripts \code{glitchMetrics.Rscript}, \code{correlationMetric.Rscript}, \code{pressureCorrelation.Rscript}}
    \item{New \code{trace@stats@processing} slot for data processing information.}
    \item{New \code{Stream} methods: \code{mergeTraces}, \code{plot}}
    \item{Improved \code{getGaps.Stream()} method properly handles initial and final gaps.}
    \item{Improved MCR error messing.}
  }
  
  version 0.1.8.0 -- IrisClient methods getEvent and getTraveltime, improved SNR metric
  
  version 0.1.7.0 -- PSD

  version 0.1.6.0 -- improved errors, miniSEED parser
  
  version 0.1.5.0 -- code cleanup, improved errors, package vignette
  
  version 0.1.4.0 -- STA/LTA, upDownTimes, basic plotting
  
  version 0.1.3.0 -- SNR, memory profiling
  
  version 0.1.2.0 -- ...
  
  version 0.1.1.0 -- ...
}

\seealso{
% Optional links to other man pages, e.g. jonc
\code{\link{IrisClient-class}}, 
\code{\link{Trace-class}}, 
\code{\link{Stream-class}}, 
}

\examples{
# Open a connection to IRIS DMC webservices
iris <- new("IrisClient", debug=TRUE)

starttime <- as.POSIXct("2010-02-27 06:45:00", tz="GMT")
endtime <- as.POSIXct("2010-02-27 07:45:00", tz="GMT")

# Get the seismic data
st <- getDataselect(iris,"IU","ANMO","00","BHZ",starttime,endtime)

# Extract the first trace, display the metadata and plot it
tr1 <- st@traces[[1]]
show(tr1@stats)
plot(tr1)
}

%% Optional keywords
