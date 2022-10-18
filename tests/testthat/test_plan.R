testthat::test_that("plan is created and executes as expected", {
    temp_infile <- paste0("file://", tempfile(
        pattern = "mtcars",
        fileext = ".csv"
    ))

    temp_outfile <- paste0("file://", tempfile(
        pattern = "mpg",
        fileext = ".csv"
    ))

    on.exit({
        unlink(temp_infile)
        unlink(temp_outfile)
    })

    write.csv(mtcars, temp_infile)

    example_plan <- plan("mytestplan")
    example_plan <- plan_source(example_plan, temp_infile)
    example_plan <- plan_reader(example_plan, read.csv)
    example_plan <- plan_transform(example_plan, `[`, "mpg")
    example_plan <- plan_writer(example_plan, write.csv)
    example_plan <- plan_destination(example_plan, temp_outfile)

    testthat::expect_identical(
        example_plan$name, "mytestplan"
    )
    testthat::expect_identical(
        example_plan$source, temp_infile
    )
    testthat::expect_identical(
        example_plan$reader,
        list(fn = read.csv, opts = list())
    )
    testthat::expect_identical(
        example_plan$transforms, list(list(fn = `[`, opts = list("mpg")))
    )
    testthat::expect_identical(
        example_plan$writer, list(fn = write.csv, opts = list())
    )
    testthat::expect_identical(
        example_plan$destination, temp_outfile
    )
    testthat::expect_success(
        tryCatch(
            {
                plan_execute(example_plan)
                testthat::succeed(message = "Plan execution succeeded")
            },
            error = function(cond) {
                testthat::fail(
                    message = paste("Plan execution failed with error:", cond)
                )
            }
        )
    )
})
