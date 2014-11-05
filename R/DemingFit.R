
## ----deming-fit, echo=TRUE, tidy=TRUE, tidy.opts=list(width.cutoff=60)----
####
#' @title Deming Fit
#' @description  Fit a line to data that minimizes the least-squared 
#' distance of the data points from the line.
#' @details See the detailed description in DemingFit.pdf
#' @aliases DemingFit
#' @author William Cooper
#' @export DemingFit
#' @param .x A numeric vector of measurements from one source.
#' @param .y A numeric vector of measurements from another source.
#' @param .sdx A numeric vector specifying the standard 
#' measurement uncertainty for the first set of measurements. Default: 1
#' @param .sdy Like .sdx but for the second set of measurements.
#' @return c(a, b, rms) for a fit of the form y = a + b * x, or NULL if no fit is possible (e.g., too few points or zero correlation)
#' @examples DemingFit ((1:5+rnorm(5,0,0.5)), (1:5+rnorm(5,0,0.5)))
#' xe <- 1:5 + rnorm (5, 0, 1)
#' ye <- 1:5 + rnorm (5, 0, 1)
#' DemingFit (xe, ye)
#' \dontrun{Fit <- DemingFit (x, y, sdx, sdy)}
DemingFit <- function (.x, .y, .sdx=1, .sdy=1) {
  ratio <- .sdy / .sdx
  xbar <- mean (.x, na.rm=TRUE)
  ybar <- mean (.y/ratio, na.rm=TRUE)
  x2bar <- mean (.x**2, na.rm=TRUE)
  y2bar <- mean ((.y/ratio)**2, na.rm=TRUE)
  xybar <- mean (.x*.y/ratio, na.rm=TRUE)
  theta <- 0.5 * atan ( 2 * (xybar - xbar * ybar) / 
                        ( (x2bar - xbar**2) - (y2bar - ybar**2)))
# xybar - xbar * ybar has the same sign as the correlation coefficient
  b <- ifelse ( ( (xybar-xbar*ybar)*theta >= 0), (tan (theta)), (-1/tan(theta)))
  a <- ybar - b * xbar
  normalizedError <- sqrt (sum (((b * .x + a - .y/ratio) / .sdx)**2) / (length (.x) - 2))
  b <- b * ratio
  a <- ybar * ratio - b * xbar
# note: std err is in units appropriate to .x or ratio*.y
  return (c (a, b, normalizedError))
}


