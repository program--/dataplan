#' Create a new data plan
#' @return a new data plan
#' @export
plan <- function(name) {
    out <- list(
        name        = name,
        source      = NULL,
        reader      = NULL,
        transforms  = list(),
        writer      = NULL,
        destination = NULL
    )

    class(out) <- "data_plan"
    out
}

#' Add a source to a data plan
#' @inheritParams plan_execute
#' @param src a URI
#' @return `plan_obj`
#' @export
plan_source <- function(plan_obj, src) {
    plan_obj$source <- src
    plan_obj
}

#' Add a destination to a data plan
#' @inheritParams plan_execute
#' @param dst a URI
#' @return `plan_obj`
#' @export
plan_destination <- function(plan_obj, dst) {
    plan_obj$destination <- dst
    plan_obj
}

#' Add a reader to a data plan
#' @inheritParams plan_execute
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

#' Add a writer to a data plan
#' @inheritParams plan_execute
#' @param writer a function that takes data as the first parameter
#'               and a destination as the second
#' @param ... additional parameters passed to `writer` when executed
#' @return `plan_obj`
#' @export
plan_writer <- function(plan_obj, writer, ...) {
    plan_obj$writer <- list(
        fn = writer,
        opts = list(...)
    )

    plan_obj
}

#' Add a transformation to a data plan
#' @inheritParams plan_execute
#' @param fn a function that takes data as the first parameter
#' @param ... additional parameters passed to `fn` when executed
#' @return `plan_obj`
#' @export
plan_transform <- function(plan_obj, fn, ...) {
    plan_obj$transforms <- append(plan_obj$transforms, list(list(
        fn = fn,
        opts = list(...)
    )))

    plan_obj
}
