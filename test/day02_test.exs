defmodule Day02Test do
  use ExUnit.Case
  doctest Day02

  @tag :skip
  test "PullResult less_than_or_equal_to comparision" do
    lhs = %PullResult{red: 1, blue: 1, green: 1}
    rhs = %PullResult{red: 12, blue: 14, green: 13}
    assert PullResult.less_than_or_equal_to(lhs, rhs)

    lhs = %PullResult{red: 12, blue: 14, green: 13}
    rhs = %PullResult{red: 12, blue: 14, green: 13}
    assert PullResult.less_than_or_equal_to(lhs, rhs)

    lhs = %PullResult{red: 13, blue: 14, green: 13}
    rhs = %PullResult{red: 12, blue: 14, green: 13}
    assert !PullResult.less_than_or_equal_to(lhs, rhs)

    lhs = %PullResult{red: 12, blue: 15, green: 13}
    rhs = %PullResult{red: 12, blue: 14, green: 13}
    assert !PullResult.less_than_or_equal_to(lhs, rhs)

    lhs = %PullResult{red: 12, blue: 14, green: 14}
    rhs = %PullResult{red: 12, blue: 14, green: 13}
    assert !PullResult.less_than_or_equal_to(lhs, rhs)

    lhs = %PullResult{red: 4, blue: 3, green: -1}
    rhs = %PullResult{red: 12, blue: 14, green: 13}
    assert PullResult.less_than_or_equal_to(lhs, rhs)
  end

  @tag :skip
  test "Enum.all with PullResults" do
    max_pull = %PullResult{red: 12, blue: 14, green: 13}

    test_pulls = [%PullResult{red: 1, blue: 1, green: 1}]
    assert Enum.all?(test_pulls, fn pull -> PullResult.less_than_or_equal_to(pull, max_pull) end)

    test_pulls = [%PullResult{red: -1, blue: -1, green: -1}]
    assert Enum.all?(test_pulls, fn pull -> PullResult.less_than_or_equal_to(pull, max_pull) end)

    test_pulls = [%PullResult{red: 1, blue: 1, green: 1}, %PullResult{red: 2, blue: 2, green: 2}]
    assert Enum.all?(test_pulls, fn pull -> PullResult.less_than_or_equal_to(pull, max_pull) end)

    test_pulls = [%PullResult{red: 1, blue: 1, green: 14}]
    assert !Enum.all?(test_pulls, fn pull -> PullResult.less_than_or_equal_to(pull, max_pull) end)

    test_pulls = [
      %PullResult{red: 12, blue: 14, green: 13},
      %PullResult{red: 13, blue: 15, green: 14}
    ]

    assert !Enum.all?(test_pulls, fn pull -> PullResult.less_than_or_equal_to(pull, max_pull) end)
  end

  @tag :skip
  test "calculate_minimum_cubes" do
    pulls = [
      %PullResult{red: 0, blue: 0, green: 0},
      %PullResult{red: 1, blue: 2, green: 3},
      %PullResult{red: 4, blue: 5, green: 6}
    ]

    assert Day02.calculate_minimum_cubes(pulls) == %PullResult{red: 4, blue: 5, green: 6}
  end

  @tag :skip
  test "sample" do
    assert Day02.sum_of_the_ids_of_possible_games("day02-sample.txt") == 8
  end

  @tag :skip
  test "input" do
    assert Day02.sum_of_the_ids_of_possible_games("day02-input.txt") == 2541
  end

  @tag :skip
  test "sample calculate_power_of_games" do
    assert Day02.calculate_power_of_games("day02-sample.txt") == 2286
  end

  @tag :skip
  test "input calculate_power_of_games" do
    assert Day02.calculate_power_of_games("day02-input.txt") == 66016
  end
end
