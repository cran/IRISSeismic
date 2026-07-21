\name{taupTraveltime}
\alias{taupTraveltime}

\title{Return seismic travel time information using \code{The TauP Toolkit}}

\description{
The \code{taupTraveltime} function returns seismic travel time data 
computed using \code{The TauP Toolkit} (Crotwell, et al., 1999). 

software: The TauP Toolkit, version 3.1.0, released 2025-08-15  
author: Crotwell, H. Philip \email{crotwell@seis.sc.edu} 
repository-code: \url{https://github.com/crotwell/TauP} 
url: \url{http://www.seis.sc.edu/TauP/}  
repository: \doi{10.5281/zenodo.10794857}
}

\usage{
taupTraveltime(latitude, longitude, depth = 0, staLatitude, staLongitude)
}

\arguments{
  \item{latitude}{ latitude of seismic event }
  \item{longitude}{ longitude of seismic event }
  \item{depth}{ depth of seismic event }
  \item{staLatitude}{ latitude of seismic station }
  \item{staLongitude}{ longitude of seismic station }
}

\details{
\code{taupTraveltime} is a wrapper for the travel time functionality of 
\code{The TauP Toolkit}.  It returns seismic travel times, calculated 
using a 1-D spherical model, in a dataframe. It is written to replace 
the deprecated \code{getTraveltime} function that retrieved seismic 
travel time information from EarthScope web services.  

software: The TauP Toolkit, version 3.1.0, released 2025-08-15
author: Crotwell, H. Philip \email{crotwell@seis.sc.edu}
repository-code: \url{https://github.com/crotwell/TauP}
url: \url{http://www.seis.sc.edu/TauP/}
repository: \doi{10.5281/zenodo.10794857}

A modified version of the TauP Toolkit can be used by setting an environmental
variable \code{TAUP_JAR_DIR} that points to a local directory containing
the jar files in the lib directory of TauP.
}


\value{
A dataframe with the following columns:

%% max preformatted length ---------------------------------------------------
\preformatted{
distance, depth, phaseName, travelTime, rayParam, takeoff, incident
  puristDistance, puristName 
}

Rows are ordered by travel time.
}

\references{
Crotwell, H. P., T. J. Owens, J. Ritsema (1999). The TauP Toolkit: Flexible
seismic travel-time and ray-path utilities,
Seismological Research Letters \bold{70}, 154--160.
}

\author{
Gillian Sharer \email{gillian.sharer@earthscope.org}
}


\examples{
\dontrun{

# Two days around the "Nisqually Quake"
iris <- new('IrisClient')
starttime <- as.POSIXct("2001-02-27", tz="GMT")
endtime <- starttime + 3600 * 24 * 2

# Find biggest seismic event over these two days -- it's the "Nisqually"
events <- getEvent(iris, starttime, endtime, minmag=5.0)
bigOneIndex <- which(events$magnitude == max(events$magnitude))
bigOne <- events[bigOneIndex[1],]

# Find US stations that are available within an hour of the event
start <- bigOne$time
end <- start + 3600
availability <- getChannel(iris, "US", "", "", "BHZ",
                           starttime=start, endtime=end,
                           latitude=bigOne$latitude, longitude=bigOne$longitude,
                           minradius=0, maxradius=10)
    
# Get the station the furthest East
minLonIndex <- which(availability$longitude == max(availability$longitude))
snclE <- availability[minLonIndex,]

# Plot the BHZ signal from this station
st <- getDataselect(iris,snclE$network,snclE$station,snclE$location,snclE$channel,
                    start,end)

# Check that there is only a single trace and then plot it
length(st@traces)
tr <- st@traces[[1]]
plot(tr, subsampling=1) # need subsmpling=1 to add vertical lines with abline()

# Find travel times to this station
traveltimes <- taupTraveltime(bigOne$latitude, bigOne$longitude, bigOne$depth,
                             snclE$latitude, snclE$longitude)

# Look at the list                             
traveltimes

# mark the P and S arrival times
pArrival <- start + traveltimes$travelTime[traveltimes$phaseName=="P"]
sArrival <- start + traveltimes$travelTime[traveltimes$phaseName=="S"] 
abline(v=pArrival, col='red')
abline(v=sArrival, col='blue')
}
}

