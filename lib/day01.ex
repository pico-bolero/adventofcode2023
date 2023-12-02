defmodule Day01 do
  @moduledoc """
  Documentation for `Day01`.
  """

  @doc """
  Get the input from advent of code from https://adventofcode.com/2023/day/1/input
  However, you need to be logged into get your specific inputs
  """
  def sum_of_all_calibration_numbers do
    File.read!("day01-input.txt")
    |> String.split("\n")
    |> Enum.map(fn x ->
      String.replace(x, ~r/[^\d]/, "")
    end)
    |> Enum.map(fn x ->
      len = String.length(x)
      String.at(x, 0) <> String.at(x, len - 1)
    end)
    |> Enum.map(fn x -> String.to_integer(x) end)
    |> Enum.sum()
  end

  @doc """
  Get the input from advent of code from https://adventofcode.com/2023/day/1/input
  However, you need to be logged into get your specific inputs
  """
  def sum_of_all_calibration_numbers_with_text_support do
    File.read!("day01-input.txt")
    |> String.split("\n")
    |> Enum.map(fn x -> Regex.replace(~r/oneight/, x, "18", global: true) end)
    |> Enum.map(fn x -> Regex.replace(~r/twone/, x, "21", global: true) end)
    |> Enum.map(fn x -> Regex.replace(~r/threeight/, x, "38", global: true) end)
    |> Enum.map(fn x -> Regex.replace(~r/fiveight/, x, "58", global: true) end)
    |> Enum.map(fn x -> Regex.replace(~r/sevenine/, x, "79", global: true) end)
    |> Enum.map(fn x -> Regex.replace(~r/eightwo/, x, "82", global: true) end)
    |> Enum.map(fn x -> Regex.replace(~r/eighthree/, x, "83", global: true) end)
    |> Enum.map(fn x -> Regex.replace(~r/nineight/, x, "83", global: true) end)
    |> Enum.map(fn x -> Regex.replace(~r/one/, x, "1", global: true) end)
    |> Enum.map(fn x -> Regex.replace(~r/two/, x, "2", global: true) end)
    |> Enum.map(fn x -> Regex.replace(~r/three/, x, "3", global: true) end)
    |> Enum.map(fn x -> Regex.replace(~r/four/, x, "4", global: true) end)
    |> Enum.map(fn x -> Regex.replace(~r/five/, x, "5", global: true) end)
    |> Enum.map(fn x -> Regex.replace(~r/six/, x, "6", global: true) end)
    |> Enum.map(fn x -> Regex.replace(~r/seven/, x, "7", global: true) end)
    |> Enum.map(fn x -> Regex.replace(~r/eight/, x, "8", global: true) end)
    |> Enum.map(fn x -> Regex.replace(~r/nine/, x, "9", global: true) end)
    |> Enum.map(fn x ->
      String.replace(x, ~r/[^\d]/, "")
    end)
    |> Enum.map(fn x ->
      len = String.length(x)
      String.at(x, 0) <> String.at(x, len - 1)
    end)
    |> Enum.map(fn x -> String.to_integer(x) end)
    |> Enum.sum()
  end
end
