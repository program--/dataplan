#' Execute a data plan
#' @param plan_obj a `data_plan` object.
#' @export
plan_execute <- function(plan_obj) {
    if (!is.null(plan_obj$reader$fn)) {
        x <- do.call(
            plan_obj$reader$fn,
            c(list(plan_obj$source), plan_obj$reader$opts)
        )
    } else {
        x <- plan_obj$source
    }

    if (length(plan_obj$transforms) > 0) {
        for (transformer in plan_obj$transforms) {
            x <- do.call(transformer$fn, c(list(x), transformer$opts))
        }
    }

    if (!is.null(plan_obj$writer) && !is.null(plan_obj$destination)) {
        do.call(plan_obj$writer$fn, c(
            list(x, plan_obj$destination),
            plan_obj$writer$opts
        ))
    }

    invisible(x)
}
