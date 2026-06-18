\docType{package}                                                                                                               
\name{IRISSeismic-deprecated}
\alias{IRISSeismic-deprecated}

\title{Deprecated Functions in Package 'IRISSeismic'}

\description{
  These functions are deprecated and may be defunct as soon as the next release.

  \itemize{
    \item{ \code{getAvailability.IrisClient}: getAvailability has a dependency
      on the EarthScope station web service parameters 'matchtimeseries' and
      'includeavailability' which are no longer available. Without these 
      parameters, getAvailability returns the same result as 
      \code{getChannel.IrisClient}.
    }
    \item{ \code{getUnavailability.IrisClient}: getUnavailability has a dependency    
      on the EarthScope station web service parameters 'matchtimeseries' and      
      'includeavailability' which are no longer available. Without these
      parameters, getUnavailability returns an empty dataframe.
    }
  }
}
