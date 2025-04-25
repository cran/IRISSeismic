.onLoad <- function(libname, pkgname) {
    irisNetrc <<- NULL
    if (Sys.getenv("IrisClient_netrc") != "") {
        irisNetrc <<- Sys.getenv("IrisClient_netrc")
    }

    #alternate authorization as "login:password" string
    irisPass <<- NULL
    if (Sys.getenv("IrisClient_passw") != "") {
        irisPass <<- Sys.getenv("IrisClient_passw")
    }
}

.onUnload <- function(libpath) {
    rm('irisNetrc','irisPass') 
}
