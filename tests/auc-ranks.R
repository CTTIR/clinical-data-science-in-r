# Exercise the published chapter expressions, including large integer outcomes.
read_expression <- function(path, name) {
  extracted <- tempfile(fileext = ".R")
  on.exit(unlink(extracted))
  knitr::purl(path, output = extracted, quiet = TRUE)
  matches <- Filter(function(x) is.call(x) && identical(x[[1L]], as.name("<-")) &&
    identical(x[[2L]], as.name(name)), as.list(parse(extracted)))
  stopifnot(length(matches) == 1L)
  matches[[1L]][[3L]]
}
auc <- eval(read_expression("chapters/b05-from-baseline-to-learning-model.qmd", "auc"))
expression_b06 <- read_expression("chapters/b06-accuracy-calibration-utility.qmd", "auc_test")
auc_b06 <- function(p, y) eval(expression_b06, envir = environment())
pairwise <- function(p, y) {
  pairs <- outer(p[y == 1L], p[y == 0L], "-")
  mean((pairs > 0) + 0.5 * (pairs == 0))
}
for (calculate in list(auc, auc_b06)) {
  for (p in list(c(.1, .9, .2, .8), c(.4, .4, .2, .4), c(3, 2, 1, 0))) {
    y <- c(0L, 1L, 0L, 1L)
    stopifnot(isTRUE(all.equal(calculate(p, y), pairwise(p, y))))
  }
  y <- rep(0:1, each = 50000L)
  warnings <- character()
  result <- withCallingHandlers(c(calculate(y, y), calculate(-y, y), calculate(rep(1, length(y)), y)),
    warning = function(w) { warnings <<- c(warnings, conditionMessage(w)); invokeRestart("muffleWarning") })
  stopifnot(length(warnings) == 0L, identical(result, c(1, 0, .5)))
}
cat("Both chapter AUC expressions match pairwise references and large integer boundary cases.\n")
