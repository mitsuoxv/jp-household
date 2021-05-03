test_that("filter works in an example", {
  testServer(showMapServer, {
    session$setInputs(level = "5", select = "010120010", year = 2007)

    expect_equal(data()$area_code[1], "00000")
    expect_equal(data()$city_e[1], "National")
    expect_equal(data()$value[1], 8249)
    expect_equal(data()$ranks[1], NA_real_)
  })
})
