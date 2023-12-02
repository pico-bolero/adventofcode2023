defmodule Day01Test do
  use ExUnit.Case
  doctest Day01

  test "sum all calibration numbers" do
    assert Day01.sum_of_all_calibration_numbers() == 54953
  end

  test "sum all calibration numbers with text support" do
    assert Day01.sum_of_all_calibration_numbers_with_text_support() == 53868
  end

end
