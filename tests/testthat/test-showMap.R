test_that("filter works in an example", {
  testServer(showMapServer, {
    session$setInputs(level = "5", select = "010120010", year = 2007)

    expect_equal(data()$level[1], "5")
    expect_equal(data()$area_code[1], "01003")
    expect_equal(data()$city_e[1], "01100 Sapporo")
    expect_equal(data()$value[1], 6647)
    expect_equal(data()$ranks[1], 43)
  })
})
