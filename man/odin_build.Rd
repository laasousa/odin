% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/odin_build.R
\name{odin_build}
\alias{odin_build}
\title{Build an odin model generator from its IR}
\usage{
odin_build(x, options = NULL)
}
\arguments{
\item{x}{An odin ir (json) object or output from
\code{\link{odin_validate}}.}

\item{options}{Options to pass to the build stage (see
\code{\link{odin_options}}}
}
\description{
Build an odin model generator from its intermediate
representation, as generated by \code{\link{odin_parse}}.  This
function is for advanced use.
}
\details{
In applications that want to inspect the intermediate
representation rather before compiling, rather than directly using
\code{\link{odin}}, use either \code{\link{odin_parse}} or
\code{\link{odin_validate}} and then pass the result to
\code{odin_build}.

The return value of this function includes information about how
long the compilation took, if it was successful, etc, in the same
style as \code{\link{odin_validate}}:

\describe{
\item{success}{Logical, indicating if compilation was successful}

\item{elapsed}{Time taken to compile the model, as a
\code{proc_time} object, as returned by \code{\link{proc.time}}.}

\item{output}{Any output produced when compiling the model (only
present if compiling to C, and if the cache was not hit.}

\item{model}{The model itself, as an \code{odin_generator} object,
as returned by \code{\link{odin}}.}

\item{ir}{The intermediate representation.}

\code{error}{Any error thrown during compilation}
}
}
\examples{
##' # Parse a model of exponential decay
ir <- odin::odin_parse({
  deriv(y) <- -0.5 * y
  initial(y) <- 1
})

# Compile the model:
options <- odin::odin_options(target = "r")
res <- odin::odin_build(ir, options)

# All results:
res

# The model:
mod <- res$model()
mod$run(0:10)
}
\seealso{
\code{\link{odin_parse}}, which creates intermediate
  representations used by this function.
}
