% Generated by roxygen2 (4.1.1): do not edit by hand
% Please edit documentation in R/IOFunctions.R
\name{SF.applyDecTable}
\alias{SF.applyDecTable}
\title{Apply for obtaining a new decision table}
\usage{
SF.applyDecTable(decision.table, object, control = list())
}
\arguments{
\item{decision.table}{a \code{"DecisionTable"} class representing a decision table. See \code{\link{SF.asDecisionTable}}.}

\item{object}{a class resulting from feature selection (e.g., \code{\link{FS.reduct.computation}}), discretization (e.g., \code{\link{D.discretization.RST}}),
 instance selection functions
(e.g., \code{\link{IS.FRIS.FRST}}), and missing value completion (e.g., \code{\link{MV.missingValueCompletion}}).}

\item{control}{a list of other parameters which are \code{indx.reduct} representing an index of the chosen decision reduct. It is only considered when
we calculate all reducts using \code{\link{FS.all.reducts.computation}}. The default value is that the first reduct will be chosen.}
}
\value{
A new decision table. Especially for the new decision table resulting from discretization, we
        obtain a different representation. Values are expressed in intervals instead of labels. For example,
        \eqn{a_1 = [-Inf, 1.35]} refers to the value \eqn{a_1} has a value in that range.
}
\description{
It is used to apply a particular object/model for obtaining a new decision table. In other words, in order to use the function,
the models, which are objects of missing value completion, feature selection, instance selection, or
discretization, have been calculated previously .
}
\examples{
#############################################################
## Example 1: The feature selection in RST
## using quickreduct
#############################################################
data(RoughSetData)
decision.table <- RoughSetData$hiring.dt

## generate reducts
red.1 <- FS.quickreduct.RST(decision.table)

new.decTable <- SF.applyDecTable(decision.table, red.1)

#############################################################
## Example 2: The feature selection in FRST
## using fuzzy.QR (fuzzy quickreduct)
#############################################################
data(RoughSetData)
decision.table <- RoughSetData$hiring.dt

## fuzzy quickreduct using fuzzy lower approximation
control <- list(decision.attr = c(5), t.implicator = "lukasiewicz",
                type.relation = c("tolerance", "eq.1"), type.aggregation =
                c("t.tnorm", "lukasiewicz"))
red.2 <- FS.quickreduct.FRST(decision.table, type.method = "fuzzy.dependency",
                            type.QR = "fuzzy.QR", control = control)

## generate new decision table
new.decTable <- SF.applyDecTable(decision.table, red.2)

###################################################
## Example 3: The Instance selection by IS.FRPS and
## generate new decision table
###################################################
dt.ex1 <- data.frame(c(0.5, 0.2, 0.3, 0.7, 0.2, 0.2),
                  c(0.1, 0.4, 0.2, 0.8, 0.4, 0.4), c(0, 0, 0, 1, 1, 1))
colnames(dt.ex1) <- c("a1", "a2", "d")
decision.table <- SF.asDecisionTable(dataset = dt.ex1, decision.attr = 3)

## evaluate and select instances
res.1 <- IS.FRPS.FRST(decision.table, type.alpha = "FRPS.3")

## generate new decision table
new.decTable <- SF.applyDecTable(decision.table, res.1)

#################################################################
## Example 4: Discretization by determining cut values and
## then generate new decision table
#################################################################
dt.ex2 <- data.frame(c(1, 1.2, 1.3, 1.4, 1.4, 1.6, 1.3), c(2, 0.5, 3, 1, 2, 3, 1),
                             c(1, 0, 0, 1, 0, 1, 1))
colnames(dt.ex2) <- c("a", "b", "d")
decision.table <- SF.asDecisionTable(dataset = dt.ex2, decision.attr = 3,
                  indx.nominal = 3)

## get cut values using the local strategy algorithm
cut.values <- D.discretization.RST(decision.table, type.method = "global.discernibility")

## generate new decision table
new.decTable <- SF.applyDecTable(decision.table, cut.values)

#################################################################
## Example 5: Missing value completion
#################################################################
dt.ex1 <- data.frame(
     c(100.2, 102.6, NA, 99.6, 99.8, 96.4, 96.6, NA),
     c(NA, "yes", "no", "yes", NA, "yes", "no", "yes"),
     c("no", "yes", "no", "yes", "yes", "no", "yes", NA),
     c("yes", "yes", "no", "yes", "no", "no", "no", "yes"))
colnames(dt.ex1) <- c("Temp", "Headache", "Nausea", "Flu")
decision.table <- SF.asDecisionTable(dataset = dt.ex1, decision.attr = 4,
                                    indx.nominal = c(2:4))

## missing value completion
val.NA = MV.missingValueCompletion(decision.table, type.method = "globalClosestFit")

## generate new decision table
new.decTable <- SF.applyDecTable(decision.table, val.NA)
new.decTable
}
\author{
Lala Septem Riza and Andrzej Janusz
}

