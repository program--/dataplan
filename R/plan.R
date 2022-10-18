#' Create a new data plan
#' @return a new data plan
#' @export
plan <- function(name) {
    out <- list(
        name       = name,
        source     = NULL,
        reader     = NULL,
        transforms = list()
    )

    class(out) <- "data_plan"
    out
}

#' Add a source to a data plan
#' @param plan_obj a `data_plan` object.
#' @param src a URI
#' @return `plan_obj`
#' @export
plan_source <- function(plan_obj, src) {
    plan_obj$source <- src
    plan_obj
}

#' Add a destination to a data plan
#' @param plan_obj a `data_plan` object.
#' @param dst a URI
#' @return `plan_obj`
#' @export
plan_destination <- function(plan_obj, dst) {
    plan_obj$destination <- dst
    plan_obj
}

#' Add a reader to a data plan
#' @inheritParams plan_source
#' @param reader a function that takes a character object as its first parameter
#' @param ... additional parameters passed to `reader` when executed
#' @return `plan_obj`
#' @export
plan_reader <- function(plan_obj, reader, ...) {
    plan_obj$reader <- list(
        fn = reader,
        opts = list(...)
    )

    plan_obj
}

plan_writer <- function(plan_obj, writer, ...) {
    plan_obj$writer <- list(
        fn = writer,
        opts = list(...)
    )

    plan_obj
}

plan_transform <- function(plan_obj, fn, ...) {
    plan_obj$transforms <- append(plan_obj$transforms, list(list(
        fn = fn,
        opts = list(...)
    )))

    plan_obj
}

plan_execute <- function(plan_obj) {
    x <- do.call(
        plan_obj$reader$fn,
        c(list(plan_obj$source), plan_obj$reader$opts)
    )

    for (transformer in plan_obj$transforms) {
        x <- do.call(transformer$fn, c(list(x), transformer$opts))
    }

    x
}
