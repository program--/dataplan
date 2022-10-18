#' @export
print.data_plan <- function(x, ...) {
    reader_header <- capture.output(str(x$reader$fn))
    writer_header <- capture.output(str(x$writer$fn))

    cli::cli({
        cli::cli_h1("Data Plan: {x$name}")
        cli::cli_dl(items = c(
            Source      = x$source,
            Reader      = reader_header,
            Destination = x$destination,
            Writer      = writer_header
        ))
    })

    invisible(x)
}
