#' @title Rmutate
#' @description Given a RANADU-convention data.frame or tibble, this function
#' adds variables as specified by equations in the second argument. The remainder
#' of the data.frame is preserved, with attributes. Note that the new variables
#' do not have attributes, even the "Dimension" attribute, so the modified
#' data.frame will not be accepted by some functions, notably makeNetCDF(),
#' unless the required attributes are added. 
#' @details The function uses the routine dplyr::mutate but after calling
#' that routine it transfers data.frame and variable attributes to the
#' resulting data.frame. This is suitable for use in pipes like
#' D %>% Rmutate(DPD=ATX-DPXC) $>$ select(Time, ATX) %>% plotWAC()
#' @aliases Rmutate, rmutate
#' @author William Cooper
#' @importFrom dplyr mutate
#' @export Rmutate
#' @param .d A data.frame or tibble that follows RANADU conventions. It normally
#' should contain a POSIXCT-format variable named "Time" and any variables
#' needed for the calculation of the new variable.
#' @param ... A set of definitions that will be used to construct new variables.
#' For example, DPD=ATX-DPXC, WICby2=WIC/2
#' @return A new data.frame or tibble with the new variables included.
#' @example DS <- Rmutate(RAFdata, DPD = ATX - DPXC)
Rmutate <- function (.d, ...) {
  transferAttributes <- function (d, dsub) {  
    ds <- dsub
    ## ds and dsub are the new variables; d is the original
    for (nm in names (ds)) {
      var <- sprintf ("d$%s", nm)
      A <- attributes (eval (parse (text=var)))
      if (!grepl ('Time', nm)) {
        A$dim[1] <- nrow(ds)
        A$class <- NULL
      } else {
        A$dim <- nrow (ds)
      }
      attributes (ds[,nm]) <- A
    }
    A <- attributes (d)
    ## If there is a 'dim' attribute, change it as appropriate:
    if ('dim' %in% names(A)) {
      A$dim <- nrow(ds)
    }
    A$Dimensions$Time$len <- nrow (ds)
    A$row.names <- 1:nrow (ds)
    A$names <- names (ds)
    attributes (ds) <- A
    return(ds)
  }
  dt <- dplyr::mutate(.d, ...)
  return (transferAttributes(.d, dt))
}
