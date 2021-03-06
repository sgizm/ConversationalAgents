% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/ParseWorkflowSpecifications.R
\name{ToLatentSemanticAnalysisWorkflowCode}
\alias{ToLatentSemanticAnalysisWorkflowCode}
\title{Interpret Latent semantic analysis workflow natural language commands.}
\usage{
ToLatentSemanticAnalysisWorkflowCode(command, parse = TRUE)
}
\arguments{
\item{command}{A string with a command or a list of commands separated with ";".}

\item{parse}{A Boolean should the result be parsed as an R expression.}
}
\value{
A string or an R expression
}
\description{
Invokes the Raku module DSL::English::LatentSemanticAnalysisWorkflows in order to get
interpretation of a natural language command or a list spoken commands separated with ";".
}
\details{
Produces a character vector or an expression depending on \code{parse}.
}
\seealso{
Other Spoken dplyr: 
\code{\link{ToDataQueryWorkflowCode}()},
\code{\link{ToEpidemiologyModelingWorkflowCode}()},
\code{\link{ToQuantileRegressionWorkflowCode}()},
\code{\link{ToRecommenderWorkflowCode}()},
\code{\link{ToSearchEngineQueryCode}()}
}
\concept{Spoken dplyr}
