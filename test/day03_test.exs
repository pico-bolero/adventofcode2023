defmodule Day03Test do
  use ExUnit.Case
  doctest Day03

  @tag :skip
  test "extract number ranges" do
    data = Day03.extract_number_ranges("467..114..",[])
    if data do
      assert data == [%{indices: {5, 3}, substring: "114", value: 114}, %{indices: {0, 3}, substring: "467", value: 467}]
    else
      raise "failure"
    end

  end

  @tag :skip
  test "extract symbol indices" do
    data = Day03.extract_symbol_indices("abcdABCD01234.-!@#$%^&*=/\.abcdABCD01234")
    assert data == [{14, "-"}, {15, "!"}, {16, "@"}, {17, "#"}, {18, "$"}, {19, "%"}, {20, "^"}, {21, "&"}, {22, "*"}, {23, "="}, {24, "/"}]
  end

  @tag :skip
  test "sample sum number adjacent to symbols" do
    assert Day03.sum_numbers_adjacent_to_symbols("day03-sample.txt") == 4361
  end

  @tag :skip
  test "input reduced sum number adjacent to symbols" do
    assert Day03.sum_numbers_adjacent_to_symbols("day03-input-reduced.txt") == 6891
  end


  test "input sum number adjacent to symbols" do
    # too low: 64627
    # too high: 544312
    assert Day03.sum_numbers_adjacent_to_symbols("day03-input.txt") == 544312
  end
end
