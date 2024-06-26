% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/model_workflow.R
\name{summarize_classes}
\alias{summarize_classes}
\title{Calculate model metrics given a confusion matrix. Useful for non-binary matricies}
\usage{
summarize_classes(all_metric_stats, num_classes, metric)
}
\arguments{
\item{all_metric_stats}{A matrix taken from a confusion matrix of all the stats}

\item{num_classes}{The number of classes in the matrix}

\item{metric}{The metric to calculate the average for}
}
\value{
a double
}
\description{
Calculate model metrics given a confusion matrix. Useful for non-binary matricies
}
\examples{
sample_stats <- c(0.3678161, 0.7134146, 0.4050633,
0.6802326, 0.4050633, 0.3678161,
0.3855422, 0.3466135, 0.3690476,
0.6107784, 0.3229167, 0.6580645,
0.3229167, 0.3690476, 0.3444444,
0.3346614, 0.3000000, 0.6959064,
0.3157895, 0.6800000, 0.3157895,
0.3000000, 0.3076923, 0.3187251,
0.12749004, 0.3147410, 0.5406154,
0.12350598, 0.3824701, 0.4899130,
0.09561753, 0.3027888, 0.4979532)
summarize_classes(sample_stats,3,"Sensitivity")
}
