% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/internalPLS.R
\name{sgspls-internal}
\alias{sgspls-internal}
\alias{group.sparse.subgroup.penalty}
\alias{deflate.pls}
\alias{checkalphas}
\title{Internal sgspls functions}
\usage{
group.sparse.subgroup.penalty(M, svd.M, keepX = NA, keepY = NA,
  groupX = NA, groupY = NA, subgroupX = NA, subgroupY = NA,
  alpha1.x = 0, alpha2.x = 0, alpha1.y = 0, alpha2.y = 0, tol = 1e-06,
  max.iter = 500, lambda.x = 0, lambda.y = 0, newtry = T)

deflate.pls(X, Y, u, v, mode)

checkalphas(alpha)
}
\description{
Internal sgspls functions
}
\details{
These are not intended for use by the user.
  \code{softhresh(Mx,lambda)} provides soft thresholding on vector Mx with
  parameter lambda, \code{checkalphas} checks if the alpha values entered are
  appropriate.
}
\author{
Matthew Sutton
}