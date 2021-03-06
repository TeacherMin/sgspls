% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/sgspls.R
\name{sgspls}
\alias{sgspls}
\title{Sparse Group Subgroup PLS}
\usage{
sgspls(X, Y, ncomp = 2, mode = "regression", keepX = NA, keepY = NA,
  max.iter = 500, tol = 1e-12, scale.x = T, scale.y = F,
  groupX = rep(1, ncol(X)), groupY = rep(1, ncol(Y)), subgroupX = rep(1,
  ncol(X)), subgroupY = rep(1, ncol(Y)), indiv_sparsity_x = rep(0, ncomp),
  subgroup_sparsity_x = rep(0, ncomp), indiv_sparsity_y = rep(0, ncomp),
  subgroup_sparsity_y = rep(0, ncomp), ...)
}
\arguments{
\item{X}{A matrix of regressors (n x p). By default the matrix will be
centered to have mean zero.}

\item{Y}{A matrix of continuous responses (n x q). By default the matrix will
be centered to have mean zero.}

\item{ncomp}{The number of components to include in the model.}

\item{mode}{A character string. What type of PLS algorithm to use, matching
one of "regression", "canonical". See Details.}

\item{keepX}{Numeric vector of length \code{ncomp}, the number of groups to
select in \eqn{X}-loadings. Default selects all groups.}

\item{keepY}{Numeric vector of length \code{ncomp}, the number of groups to
select in \eqn{Y}-loadings. Default selects all groups.}

\item{max.iter}{How many iterations should be performed? Default is 500.}

\item{tol}{A positive real tolerance for the PLS algorithm.}

\item{scale.x}{Scale predictors by their standard deviation.}

\item{scale.y}{Scale responses by their standard deviation.}

\item{groupX}{A vector describing the group details of the X variable. (see
example in Details).}

\item{groupY}{A vector describing the group details of the Y variable. (see
example in Details).}

\item{subgroupX}{A vector describing the subgroup details of the X block (see
example in Details).}

\item{subgroupY}{A vector describing the subgroup details of the Y block (see
example in Details).}

\item{indiv_sparsity_x}{Individual sparisty parameter (value between 0 and 1)
related to the sparisty within subgroups for the \eqn{X} block.}

\item{subgroup_sparsity_x}{Sub-group sparisty parameter (value between 0 and
1) related to the number of subgroups selected for the PLS \eqn{X} weights.}

\item{indiv_sparsity_y}{Individual sparisty parameter (value between 0 and 1)
related to the sparisty within subgroups for the \eqn{Y} block.}

\item{subgroup_sparsity_y}{Sub-group sparisty parameter (value between 0 and
1) related to the number of subgroups selected for the PLS \eqn{Y} weights.}

\item{...}{additional arguments for low level functionality.}
}
\value{
\code{sgspls} returns an object of class \code{"sgspls"}, a list that
contains the following components: 
\item{weights}{a list containing the X and Y pls weights.} 
\item{scores}{a list containing the X and Y pls scores.} 
\item{names}{a list containing the X and Y names.} 
\item{parameters}{a list containing the parameters of the model that was fitted.}
}
\description{
Fit a PLS model to two blocks of data via the sparse group subgroup Partial
Least Squares (sgspls) algorithm. The sgspls algorithm enables selection of
variables at the group, subgroup and single feature levels.
}
\examples{

set.seed(1)
n = 50; p = 510; 

size.groups = 30; size.subgroups = 5
groupX <- ceiling(1:p / size.groups)
subgroupX <- ceiling(1:p / size.subgroups)

X = matrix(rnorm(n * p), ncol = p, nrow = n)

beta <- rep(0,p)
bSG <- -2:2; b0 <- rep(0,length(bSG))
betaG <- c(bSG, b0, bSG, b0, bSG, b0)
beta[1:size.groups] <- betaG

y = X \%*\% beta + 0.1*rnorm(n)

model <- sgspls(X, y, ncomp = 3, mode = "regression", keepX = 1,
                groupX = groupX, subgroupX = subgroupX,
                indiv_sparsity_x = 0.8, subgroup_sparsity_x = 0.15)

reg_coef <- coef(model, type = "coefficients")

# Check model fit
cbind(reg_coef$B[ , , 3], beta)

\dontrun{
cbind(model.sgsplsR$B.hat[,,3], beta)[1:30,]
}
}
\references{
Liquet Benoit, Lafaye de Micheaux, Boris Hejblum, Rodolphe
  Thiebaut. A group and Sparse Group Partial Least Square approach applied in
  Genomics context. \emph{Submitted}.

  L\^e Cao, K.-A., Martin, P.G.P., Robert-Grani\'e, C. and Besse, P. (2009).
  Sparse canonical methods for biological data integration: application to a
  cross-platform study. \emph{BMC Bioinformatics} \bold{10}:34.

  Shen, H. and Huang, J. Z. (2008). Sparse principal component analysis via
  regularized  low rank matrix approximation. \emph{Journal of Multivariate
  Analysis} \bold{99}, 1015-1034.

  Tenenhaus, M. (1998). \emph{La r\'egression PLS: th\'eorie et pratique}.
  Paris: Editions Technic.
}
\seealso{
Tuning functions \code{\link[sgspls]{calc_pve}},
\code{\link[sgspls]{tune_sgspls}}, \code{\link[sgspls]{tune_groups}}. 
Model performance and estimation  \code{\link[sgspls]{predict.sgspls}}, \code{\link[sgspls]{perf.sgspls}}, \code{\link[sgspls]{coef.sgspls}}
}
\author{
Matthew Sutton \email{m5.sutton@hdr.qut.edu.au}
}
