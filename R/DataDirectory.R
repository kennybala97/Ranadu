#' @title DataDirectory
#' @description Returns the location of the local data directory. 
#' @details This is intended to make it easier to write programs that work on different 
#' computers where the netCDF files by convention are stored in different locations. 
#' It returns the local location, or NA if none of the standard locations are found.
#' @aliases DataDirectory
#' @author William Cooper
#' @export DataDirectory
#' @return Directory The path to the local data directory, or NA if none found
#' @examples 
#' Directory <- DataDirectory ()
DataDirectory <- function() {
  
  # provides a local data location that varies with system:
  #    barolo: /scr/raf_data/ 
  #    laptop: /Data/
  #    LookoutHaven: /home/Data/
  #    RAF ground station: /home/data/
  #    Other:  ~/Data
  # add others as needed
  
  DataDir <- Sys.getenv ("DATA_DIR")  ## EOL systems have this environment variable
  if (file.exists (DataDir)){
    return (paste (DataDir, '/', sep=''))
  }
  DataDir <- "/scr/raf_data/"
  if (file.exists (DataDir)){
    return (DataDir)
  }
  DataDir <- "/home/data/"
  if (file.exists (DataDir)){
    return (DataDir)
  }
  DataDir <- "/home/Data/"
  if (file.exists (DataDir)){
    return (DataDir)
  }

  DataDir <- "/Data/"
  if (file.exists (DataDir)){
    return (DataDir)
  }
  DataDir <- "~/Data"
  if (file.exists (DataDir)){
    return (sprintf('%s/', DataDir))
  }
  return(NA)
} 
