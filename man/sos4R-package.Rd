\name{sos4R-package}

\docType{package}

\alias{sos4R-package}
\alias{sos4R}

\alias{sosCheatSheet}
\alias{release_questions}

\alias{cacheVariables}

\title{A client for the OGC Sensor Observation Service}

\description{
\pkg{sos4R} is a client for Sensor Observation Services (SOS). It allows users to retrieve metadata from SOS web service instances as specified by the Open Geospatial Consortium (OGC) and subsequently to interactively create requests for observation data based on the available sensors, phenomena, observations, offerings etc.
}

\details{
	\tabular{ll}{
	Package: \tab sos4R\cr
	Type: \tab Package\cr
	Version: \tab 0.4.2\cr
	Date: \tab 2020-07-08\cr
	License: \tab GPL-2\cr
	LazyLoad: \tab yes\cr
	ByteCompile: \tab yes\cr
	Imports: \tab xml2, httr, sp, uuid, methods, stats, utils, graphics\cr
	}
}

\author{
Daniel Nuest <daniel.nuest@uni-muenster.de>
}

\references{
Na, A., Priest, M. (Eds.), 2007. Sensor Observation Service. OpenGIS Implementation Standard, Version 1.0, OGC 06-009r6
}

\seealso{See also the package vignette.}

\note{
The development of this software was gratefully supported by the 52North Student Innovation Prize for Geoinformatics 2010.

To stay updated on all matters around \pkg{sos4R} go to the development blog at \url{http://www.nordholmen.net/sos4r/}.

If you want to ask questions about using the software, please go to the to the issue tracker at \url{https://github.com/52North/sos4R/issues}.

The most extensive documentation is contained in the \strong{package vignettes}.
}

\examples{

\dontrun{

# Open the connection
sos = SOS(url = "<the service endpoint>")

# List offerings, procedures and observedProperties
names(sosOfferings(sos))
sosProcedures(sos)
sosObservedProperties(sos)

# Create time period (last 30 days)
tPeriod <- sosCreateEventTimeList(
	time = sosCreateTimePeriod(
		sos = pegelsos,
		begin = Sys.time() - (3600 * 24 * 30),
		end = Sys.time()))

# Request data for all observed properties and procedures of a certain offering
observation <- getObservation(sos = sos,
		observedProperty = sosObservedProperties(sos),
		offering = sosOfferings(sos)[[2]],
		procedure = sosProcedures(sos),
		eventTime = tPeriod)

# Inspect result
sosResult(observation)
utils::str(sosResult(observation))

# Inspect attributes of the data fields
if(is.list(sosResult(observation))) {
	attributes(sosResult(observation)[,1])
}
else {
	attributes(sosResult(pegelObs)[,1])
}

# Use custom converting function and connection method. This mechanism works the
# same for encoders and decoders.
myConverters <- SosDataFieldConvertingFunctions(
	"myNumericUnit" = sosConvertDouble)
mySos <- SOS(sos.url, binding = "KVP", dataFieldConverters = myConverters)
sosDataFieldConverters(mySos)

# where to find the cheat sheet
sosCheatSheet()

# global objects caching objects during parsing of XML documents
cacheVariables
}

}

\keyword{package}
\keyword{connection}
\keyword{ts}
\keyword{spatial}
\keyword{database}
