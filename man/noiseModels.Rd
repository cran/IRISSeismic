\name{noiseModels}

\alias{noiseModels}


\title{Generate NHNM and NLNM noise models}

\description{
The \code{noiseModels} function returns the New High Noise Model and New Low Noise Model
from the Peterson paper. Values are returned for the specific frequencies specified in
the \code{freq} argument.
}

\usage{
noiseModels(freq)
}

\arguments{
  \item{freq}{a vector of frequencies at which to generate noise model values}
}

%% \details{ }

\value{
A list is returned with elements \code{nhnm} and \code{nlnm} containing the high and
low noise models, respectively.
}

\references{
\href{http://www.mttmllr.com/ADS/DATA/peterson_usgs_seismic_noise_ofr93-322.pdf}{Observations of Modeling and Seismic Background Noise} (Peterson 1993)

\href{http://pubs.usgs.gov/of/2005/1438/pdf/OFR-1438.pdf}{Seismic Noise Analysis System Using Power Spectral Density Probability Density Functions} (McNamara and Boaz 2005)
}

\author{
Jonathan Callahan \email{jonathan.s.callahan@gmail.com}
}

%% \note{ }

\seealso{
\code{\link{psdStatistics}},
}

%% \examples{ }

\keyword{spectra}
