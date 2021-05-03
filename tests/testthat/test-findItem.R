test_that("filter works when level 1, National and 2010", {
  testServer(findItemServer, {
    session$setInputs(level = "1", select_city = "National",
                      year_range = c(2010, 2010))
    
    expect_equal(nrow(city_data()), 14)
    expect_equal(city_data()$cat01_code[1], "001100000")
    expect_equal(city_data()$area_code[1], "00000")
    expect_equal(city_data()$value[1], 3482930)
  })
})
