example_plan <-
    plan("mtcars") |>
    plan_source("file://mtcars.csv") |>
    plan_reader(read.csv) |>
    plan_transform(dplyr::select, "mpg") |>
    plan_execute()
