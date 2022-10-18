write.csv(mtcars, "mtcars.csv")

example_plan <-
    plan("myexampleplan") |>
    plan_source("file://mtcars.csv") |>
    plan_reader(read.csv) |>
    plan_transform(`[`, "mpg") |>
    plan_writer(write.csv) |>
    plan_destination("file://mpg.csv") |>
    plan_execute()
