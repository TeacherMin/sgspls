% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/internal.R
\name{select.sgspls}
\alias{select.sgspls}
\title{Find selected Modules, Genes and Times}
\usage{
select.sgspls(model, module, gene, time)
}
\arguments{
\item{model}{object of class inhereting from "sgspls".}

\item{module}{A p-vector indicating group membership for each covariate in
the X-block}

\item{gene}{A p-vector indicating gene membership for each covariate in
the X-block}

\item{time}{A p-vector indicating time membership for each covariate in
the X-block}
}
\value{
Returns a list with the following selected parameter information:

\item{select.table.X}{A table detailing the number of times each gene has been selected at each timepoint and the number of consistently selected genes.}
\item{summary.table}{A table sumarising the number of modules, genes, timepoints and covariates selected.}
\item{tab.gene.X}{Lists the number of timepoint that each gene in a given module and component occurs.}
\item{tab.gene.time.X}{Table of the selected genes against time points that they occur.}
\item{consistent.genes.X}{Returns the genes that occur in every time point.}
\item{select.gene.X}{Returns the genes that are selected at least once for a given component.}
\item{select.gene.X.total}{Returns the genes that are selected at least once across any component.}
\item{selected.table.gene.X}{Returns the total number of genes selected at each component.}
}
\description{
This function finds the selected groups, subgroups and individual predictors
from a sgspls method.
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

# Beta contains 1 active module with 3 active genes
# index for modules, genes and times
mod_index <- groupX
gene_index <- subgroupX
time_index <- rep(rep(1:5,6), 17)

model <- sgspls(X, y, ncomp = 3, mode = "regression", keepX = 1,
                groupX = groupX, subgroupX = subgroupX,
                indiv_sparsity_x = 0.8, subgroup_sparsity_x = 0.15)

reg_coef <- coef(model, type = "coefficients")

# Check model fit
cbind(reg_coef$B[ , , 3], beta)

# See the estimated regression coefficient
cbind(reg_coef$B[,,3], beta, mod_index, gene_index, time_index)[1:30,]
selectedVar <- select.sgspls(model, module = mod_index, gene = gene_index, time = time_index)
# show number of selected genes for component 1
selectedVar$select.table.X$comp1
# show number of modules, genes, times and total variables selected
selectedVar$summary.table
# Show when genes were selected from given module

}
