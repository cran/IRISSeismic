##
##    Utility functions for the 'IRISSeismic' package.
##
##    Copyright (C) 2013  Mazama Science, Inc.
##    by Jonathan Callahan, jonathan@mazamascience.com
##
##    This program is free software; you can redistribute it and/or modify
##    it under the terms of the GNU General Public License as published by
##    the Free Software Foundation; either version 2 of the License, or
##    (at your option) any later version.
##
##    This program is distributed in the hope that it will be useful,
##    but WITHOUT ANY WARRANTY; without even the implied warranty of
##    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
##    GNU General Public License for more details.
##
##    You should have received a copy of the GNU General Public License
##    along with this program; if not, write to the Free Software
##    Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA


############################################################
# miniseed2Stream
#
# Converts raw miniseed bytes into a Stream object.
#
miniseed2Stream <- function(miniseed,
                            url="unknown file",
                            requestedStarttime=NULL,
                            requestedEndtime=NULL,
                            sensor="synthetic trace",
                            scale=as.integer(NA),
                            scalefreq=as.numeric(NA),   
                            scaleunits="",
                            latitude=as.numeric(NA),    
                            longitude=as.numeric(NA),   
                            elevation=as.numeric(NA),   
                            depth=as.numeric(NA),       
                            azimuth=as.numeric(NA),     
                            dip=as.numeric(NA)) {       
  
  # Use C code to parse the bytes into a list of lists  
  result <- try( segList <- parseMiniSEED(miniseed),
                 silent=TRUE  )
 
  # Handle error response
  if (inherits(result,"try-error")) {
    err_msg <- geterrmessage()
    if (stringr::str_detect(err_msg,"libmseed__zero traces in miniSEED record")) {
      stop(paste("miniseed2Stream: No data found.", url))
	} else if ((stringr::str_detect(err_msg,"Data integrity check for Steim"))) {
		# REC - May 2014 - allowing libmseed Steim coefficient errors to pass unabated
		print(paste("miniseed2Stream:",err_msg,"- Using data anyway",":",url))
    } else {
      stop(paste("miniseed2Stream:",err_msg,":",url))
    } 
    
  }  
  
  # Trace segments are returned in sorted order by the MiniSEED parser.
  # Here is what the ms_intro man page has to say:
  #
  # The  MSTraceList facility is a next generation version of the MSTraceGroup
  # facility.  Whereas the MSTraceGroup facility uses a single linked list of
  # time segments the MSTraceList facility is slightly more complex with two
  # levels of linked lists and common access  pointers.   The  advantages  are
  # that  the  MSTraceList structure is faster to populate, especially when 
  # there are many segments (gappy data), and the list is always maintained in
  # a sorted order.
  
  # Set the origin for date conversions
  origin <- as.POSIXct("1970-01-01 00:00:00", tz="GMT")
  
  traces <- list()
  for ( i in seq_along(segList) )  {
    if(!is.null(segList[[i]])){
        headerList <- list(network=segList[[i]]$network,
                       station=segList[[i]]$station,
                       location=segList[[i]]$location,
                       channel=segList[[i]]$channel,
                       quality=segList[[i]]$quality,
                       starttime=as.POSIXct(segList[[i]]$starttime, origin=origin, tz="GMT"),
                       endtime=as.POSIXct(segList[[i]]$endtime, origin=origin, tz="GMT"),   
                       npts=segList[[i]]$npts,
                       sampling_rate=segList[[i]]$sampling_rate,
                       latitude=latitude,    
                       longitude=longitude,  
                       elevation=elevation,  
                       depth=depth,          
                       azimuth=azimuth,      
                       dip=dip               
                       )
    
        stats <- new("TraceHeader", headerList=headerList)
        traces[[i]] <- new("Trace", stats=stats,
                       Sensor=sensor, 
                       InstrumentSensitivity=scale, 
                       SensitivityFrequency=scalefreq,  
                       InputUnits=scaleunits,
                       data=segList[[i]]$data)
    }
  }
  
  # Each miniSEED record has one set of quality flags (currently attached to each element in segList)
  act_flags <- segList[[1]]$act_flags
  io_flags <- segList[[1]]$io_flags
  dq_flags <- segList[[1]]$dq_flags
  timing_qual <- segList[[1]]$timing_qual

  # Create requested times if they weren't passed in
  if (is.null(requestedStarttime)) {
    requestedStarttime <- traces[[1]]@stats@starttime
  }
  if (is.null(requestedEndtime)) {
    last <- length(traces)
    requestedEndtime <- traces[[last]]@stats@endtime 
  }

  # Create a new Stream object
  stream <- new("Stream", url=url, requestedStarttime=requestedStarttime, requestedEndtime=requestedEndtime,
                act_flags=act_flags, io_flags=io_flags, dq_flags=dq_flags, timing_qual=timing_qual,
                traces=traces)
  
  return(stream)
}


############################################################
# readMiniseed
#
# Reads miniSEED bytes from a file and converts them into a Stream object.
#
readMiniseedFile <- function(file, 
                             sensor="synthetic trace", 
                             scale=as.integer(NA),     
                             scalefreq=as.numeric(NA), 
                             scaleunits="",            
                             latitude=as.numeric(NA),  
                             longitude=as.numeric(NA), 
                             elevation=as.numeric(NA), 
                             depth=as.numeric(NA),     
                             azimuth=as.numeric(NA),   
                             dip=as.numeric(NA)) {                            

  # Read in the binary data
  bytes <- file.info(file)$size
  miniseed <- readBin(file, "raw", n=bytes)
  
  # Prepare additional parameters
  url <- paste("file:",file)
  requestedStarttime <- NULL
  requestedEndtime <- NULL

  stream <- miniseed2Stream(miniseed,url,requestedStarttime,requestedEndtime,
                            sensor,scale,scalefreq,scaleunits,latitude,longitude, 
                            elevation,depth,azimuth,dip)  

  return(stream)
}


############################################################
# rotate2D
#
# Rotates non-vertical components of a seismic waveform into a new coordinate system.
#
# Functions similarly to the rotation service with "&azimuth=angle&components=ZRT"
# expects orthogonal traces
#
#   https://service.earthscope.org/irisws/rotation/1/
#   https://service.earthscope.org/irisws/rotation/docs/1/help/

rotate2D <- function(st1,st2,angle) {
  
  if (length(st1@traces) > 1) {
    stop(paste("Stream st1 has more than one trace."))
  }
  if (length(st2@traces) > 1) {
    stop(paste("Stream st2 has more than one trace."))
  }
  
  # Sanity check
  if (length(st1) != length(st2)) {
    stop(paste("Incoming streams have different data lengths."))
  }

  # need to determine which is 1 (lag, usually oriented North) and 2 (lead, usually oriented E) using metadata information

  if (!is.na(st1@traces[[1]]@stats@azimuth) && !is.na(st2@traces[[1]]@stats@azimuth)){
     az1 <- st1@traces[[1]]@stats@azimuth
     az2 <- st2@traces[[1]]@stats@azimuth
     
     azdiff <- az1-az2
     
     if ( !( (abs(azdiff) > 87 & abs(azdiff) < 93) || (abs(azdiff) > 267 & abs(azdiff) < 273) ) ) {
        stop(paste("Incoming streams are not orthogonal (+/- 3 degrees):", st1@traces[[1]]@id,": azimuth=",st1@traces[[1]]@stats@azimuth,";",st2@traces[[1]]@id,": azimuth=",st2@traces[[1]]@stats@azimuth))
     }
     

     if(azdiff < 0 ) {
        if ( azdiff <= 180 ) { 
           tr1 <- st1@traces[[1]]
           tr2 <- st2@traces[[1]]
        } else {
           tr1 <- st2@traces[[1]]
           tr2 <- st1@traces[[1]]
        }
     }else if( azdiff > 0) {
        if ( azdiff > 180 ) {
           tr1 <- st1@traces[[1]]
           tr2 <- st2@traces[[1]]
        } else {
           tr1 <- st2@traces[[1]]
           tr2 <- st1@traces[[1]]
        }
     }  
  } else { #if azimuth information is not available, assume that the first trace is lagging and the second is leading. Assume orthogonality.
     tr1 <- st1@traces[[1]]
     tr2 <- st2@traces[[1]]
  }
  
  # NOTE:  The azimuth circle is different from standard geometry!!!
  # NOTE:  
  # NOTE:       Azimuth (Z down)           Geometry (Z up)
  # NOTE:          0                          90
  # NOTE:
  # NOTE:    270       90               180        0
  # NOTE:
  # NOTE:         180                        270
  # NOTE:
  # NOTE:  From the rotation service help page:
  # NOTE:
  # NOTE:  | R |     |  cos(a)  sin(a) |   | N |
  # NOTE:  |   |  =  |                 | * |   |
  # NOTE:  | T |     | -sin(a)  cos(a) |   | E |
  # NOTE:
  
  
  # Calculate the rotation
  radians <- angle * pi/180
  R_data <-  cos(radians) * tr1@data + sin(radians) * tr2@data
  T_data <- -sin(radians) * tr1@data + cos(radians) * tr2@data
  
  # Create a new "radial" Stream object
  stR <- st1
  stR@url <- "synthetic rotation -- radial component"
  stR@traces[[1]]@data <- R_data
  parts <- unlist(stringr::str_split(stR@traces[[1]]@id,'\\.'))
  parts[4] <- stringr::str_replace(parts[4],'.$','R')
  stR@traces[[1]]@id <- paste(parts,collapse='.')
  stR@traces[[1]]@stats@channel <- parts[4]
  if ( (tr1@stats@azimuth+angle) < 360 && (tr1@stats@azimuth+angle) >= 0) { 
      stR@traces[[1]]@stats@azimuth <- tr1@stats@azimuth+angle 
  } else if ((tr1@stats@azimuth+angle) > 360) { 
      stR@traces[[1]]@stats@azimuth <- (tr1@stats@azimuth+angle)-360 
  } else if ((tr1@stats@azimuth+angle) < 0) { 
      stR@traces[[1]]@stats@azimuth <- (tr1@stats@azimuth+angle)+360 
  }
  stR@traces[[1]]@Sensor <- paste("synthetic rotation by",formatC(angle,digits=1,format="f"),"degrees",tr1@Sensor) 
  stR@traces[[1]]@InstrumentSensitivity <- tr1@InstrumentSensitivity 
  stR@traces[[1]]@InputUnits <- tr1@InputUnits  
    
  
  # Create a new "transverse" Stream object
  stT <- st1
  stT@url <- "synthetic rotation -- transverse component"
  stT@traces[[1]]@data <- T_data
  parts <- unlist(stringr::str_split(stT@traces[[1]]@id,'\\.'))
  parts[4] <- stringr::str_replace(parts[4],'.$','T')
  stT@traces[[1]]@id <- paste(parts,collapse='.')
  stT@traces[[1]]@stats@channel <- parts[4]
  if ( (tr2@stats@azimuth+angle) < 360 && (tr2@stats@azimuth+angle) >= 0) {   
      stT@traces[[1]]@stats@azimuth <- tr2@stats@azimuth+angle 
  } else if ((tr2@stats@azimuth+angle) > 360) { 
      stT@traces[[1]]@stats@azimuth <- (tr2@stats@azimuth+angle)-360 
  } else if ((tr2@stats@azimuth+angle) < 0) { 
      stT@traces[[1]]@stats@azimuth <- (tr2@stats@azimuth+angle)+360 
  }
  stT@traces[[1]]@Sensor <- paste("synthetic rotation by",formatC(angle,digits=1,format="f"),"degrees",tr2@Sensor) 
  stT@traces[[1]]@InstrumentSensitivity <- tr2@InstrumentSensitivity  
  stT@traces[[1]]@InputUnits <- tr2@InputUnits  
  
  # Return the rotated data
  return(list(stR=stR, stT=stT))
  
}

############################################################
# surfaceDistance
#
# Calculates the geodesic distance between two points using the Haversine formula.
#
# from https://www.r-bloggers.com/great-circle-distance-calculations-in-r/
#
surfaceDistance <- function(lat1_deg, lon1_deg, lat2_deg, lon2_deg) {
  
  # Convert everything to radians
  lat1 = lat1_deg * pi / 180
  lon1 = lon1_deg * pi / 180
  lat2 = lat2_deg * pi / 180
  lon2 = lon2_deg * pi / 180
  
  R <- 6371 # Earth mean radius [km]
  delta.lon <- (lon2 - lon1)
  delta.lat <- (lat2 - lat1)
  a <- sin(delta.lat/2)^2 + cos(lat1) * cos(lat2) * sin(delta.lon/2)^2
  c <- 2 * asin(pmin(1,sqrt(a)))
  d = R * c # Distance in km
  
  return(d)
}


################################################################################
# END
################################################################################
