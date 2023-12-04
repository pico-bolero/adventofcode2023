defmodule Day03 do
  @moduledoc """
  Documentation for `Day03`.
  Get the input from advent of code from https://adventofcode.com/2023/day/3/input.
  However, you need to be logged into get your specific inputs
  """

  @doc """
  Extracts information from the string and returns a list of items
  that contains the numeric value, the {index, length}, and the string
  representation.
  """
  @spec extract_number_ranges(String.t(), list) :: list
  def extract_number_ranges(str, acc \\ []) do
    substring = Regex.run(~r/\d+/, str)
    indices = Regex.run(~r/\d+/, str, return: :index)

    {str, item} =
      cond do
        substring ->
          value = String.to_integer(List.first(substring))
          substring = List.first(substring)
          indices = List.first(indices)
          {index, length} = indices
          replacement = index..(index + length - 1) |> Enum.map(fn _ -> "x" end) |> Enum.join()
          item = %{value: value, substring: substring, indices: indices}
          str = String.replace(str, substring, replacement, global: false)
          {str, item}

        true ->
          {str, nil}
      end

    acc =
      cond do
        item != nil and acc == [] ->
          extract_number_ranges(str, [item])

        item != nil ->
          extract_number_ranges(str, [item | acc])

        true ->
          acc
      end

    acc
  end

  @spec extract_symbol_indices(String.t()) :: list
  def extract_symbol_indices(str) do
    String.splitter(str, "", trim: true)
    |> Enum.with_index(fn x, index -> {index, x} end)
    |> Enum.filter(fn x ->
      {_, char} = x
      Regex.match?(~r/[^.0-9a-zA-Z]/, char)
    end)
  end

  def get_symbol_indices_for_row(row, symbol_indices_by_row) do
    # this is probably really inefficient to count each time
    row_count = Enum.count(symbol_indices_by_row)

    symbol_indices =
      Enum.filter((row - 1)..(row + 1), fn x ->
        x >= 0 and x <= row_count - 1
      end)
      |> Enum.map(fn x ->
        Enum.at(symbol_indices_by_row, x)
      end)
      |> Enum.filter(fn x -> x.symbols != [] end)
      |> Enum.flat_map(fn x ->
        Enum.map(x.symbols, fn x ->
          {index, _} = x
          index
        end)
      end)

    symbol_indices
  end

  @doc """
  Starting to get a little ugly around here. Get the symbol
  row above and below the item.
  """
  def keep_filter_part?(item, symbol_indices_by_row) do
    symbols = get_symbol_indices_for_row(item.row, symbol_indices_by_row)
    # IO.puts("Item: #{inspect(item)} Symbols: #{inspect(symbols)}")
    {index, length} = item.item.indices
    # IO.puts("Row: #{item.row} index: #{index} length: #{length}")
    keep =
      cond do
        symbols == [] ->
          true

        true ->
          !Enum.any?(symbols, fn symbol_index ->
            symbol_index <= index + length and symbol_index >= index - 1
          end)
      end

    !keep
  end

  @doc """
  Calculate the sum of the numbers in the input
  *  any number adjacent to a symbol, even diagonally, is a "part number" and should be included in your sum
  """
  @spec sum_numbers_adjacent_to_symbols(String.t()) :: integer()
  def sum_numbers_adjacent_to_symbols(fileName) do
    # Get the indices and values of the numbers
    number_indices =
      File.read!(fileName)
      |> String.split("\n")
      |> Enum.map(fn x -> extract_number_ranges(x) end)
      |> Enum.with_index(fn x, row_idx -> {row_idx, x} end)
      |> Enum.flat_map(fn x ->
        {row_idx, data_array} = x
        Enum.map(data_array, fn elem -> %{row: row_idx, item: elem} end)
      end)

    # IO.puts("#{inspect(number_indices)}")

    # Get all the symbol indices
    symbol_indices_by_row =
      File.read!(fileName)
      |> String.split("\n")
      |> Enum.map(fn x -> extract_symbol_indices(x) end)
      |> Enum.with_index(fn x, row_idx -> %{row: row_idx, symbols: x} end)

    # IO.puts("#{inspect(symbol_indices_by_row)}")

    kept =
      Enum.filter(number_indices, fn x ->
        keep_filter_part?(x, symbol_indices_by_row)
      end)

    Enum.each(kept, fn x -> IO.puts("row: #{x.row} value: #{x.item.value} ") end)

    # IO.puts("Kept: #{inspect(kept)}")
    values = Enum.map(kept, fn x -> x.item.value end)
    IO.puts("Kept: #{inspect(values)}")
    Enum.sum(values)
  end
end
