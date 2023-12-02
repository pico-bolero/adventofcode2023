defmodule PullResult do
  defstruct red: 0, blue: 0, green: 0

  @typedoc """
      Type that represents a pull from a bag
  """
  @type t :: %PullResult{red: integer, blue: integer, green: integer}

  defimpl String.Chars, for: PullResult do
    @spec to_string(PullResult.t()) :: String.t()
    def to_string(pr) do
      "red: #{inspect(pr.red)} green: #{inspect(pr.green)} blue: #{inspect(pr.blue)}"
    end
  end

  @doc """
  Parses a string into a list of PullResults
  * input example:`1 blue, 2 green`
  * input example: `1 green, 1 blue`
  * input example: `3 green, 4 blue, 1 red`
  """
  @spec parse_pull_result(String.t()) :: PullResult.t()
  def parse_pull_result(str) do
    Regex.split(~r/,/, str)
    |> Enum.map(fn x -> String.trim(x) end)
    |> Enum.map(fn x -> Regex.split(~r/ /, x) end)
    |> Enum.reduce(%PullResult{red: 0, blue: 0, green: 0}, fn x, acc ->
      value = String.to_integer(Enum.at(x, 0))
      color = Enum.at(x, 1)

      cond do
        color == "blue" -> %{acc | blue: value}
        color == "green" -> %{acc | green: value}
        color == "red" -> %{acc | red: value}
        true -> raise "unknown"
      end
    end)
  end

  @doc """
  Parses a string into a list of PullResults
  * input example:`1 blue, 2 green; 3 green, 4 blue, 1 red; 1 green, 1 blue`
  """
  @spec parse_pull_results(String.t()) :: list(PullReult.t())
  def parse_pull_results(str) do
    Regex.split(~r/;/, str) |> Enum.map(fn x -> parse_pull_result(x) end)
  end

  @doc """
  Return true iff all elements in left-hand-side(lhs) are less than or equal
  to their counterparts in right-hand-side(rhs)
  """
  @spec less_than_or_equal_to(PullRequest.t(), PullRequest.t()) :: boolean()
  def less_than_or_equal_to(lhs, rhs) do
    lhs.red <= rhs.red && lhs.blue <= rhs.blue && lhs.green <= rhs.green
  end
end

defmodule Game do
  defstruct id: nil, pulls: nil

  @typedoc """
      Type that represents a game
  """
  @type t :: %Game{id: integer, pulls: list(PullResult.t())}

  defimpl String.Chars, for: Game do
    @spec to_string(Game.t()) :: String.t()
    def to_string(game) do
      "id: #{game.id}; pulls: " <> Enum.reduce(game.pulls, "", fn x, acc -> "#{x}; #{acc}" end)
    end
  end

  @doc """
  Parses a string to extract the game id.
  * input example:`Game 2` returns 2
  """
  @spec parse_game_id(String.t()) :: integer
  def parse_game_id(str) do
    id = Regex.replace(~r/Game /, String.trim(str), "")
    String.to_integer(id)
  end

  @doc """
  Parses a line of text from the input into a Game type
  * line example:`Game 2: 1 blue, 2 green; 3 green, 4 blue, 1 red; 1 green, 1 blue`
  """
  @spec parse(String.t()) :: Game.t()
  def parse(line) do
    splits = Regex.split(~r{:}, line)
    id = parse_game_id(Enum.at(splits, 0))
    pulls = PullResult.parse_pull_results(Enum.at(splits, 1))
    %Game{id: id, pulls: pulls}
  end
end

defmodule Day02 do
  @moduledoc """
  Documentation for `Day02`.
  Get the input from advent of code from https://adventofcode.com/2023/day/2/input.
  However, you need to be logged into get your specific inputs
  """

  @doc """
  Calculate the minimum number of cubes needed for each color
  in the bag to make all the draws possible.
  """
  @spec calculate_minimum_cubes(list(PullResult.t())) :: PullResult.t()
  def calculate_minimum_cubes(pulls) do
    Enum.reduce(pulls, %PullResult{red: 0, blue: 0, green: 0}, fn x, acc ->
      red = max(acc.red, x.red)
      blue = max(acc.blue, x.blue)
      green = max(acc.green, x.green)
      %{acc | red: red, blue: blue, green: green}
    end)
  end

  @doc """
  Sum the Game IDs if it was possible to have a PullResult
  if the bag contained only 12 red cubes, 13 green cubes, and 14 blue cubes?
  """
  @spec sum_of_the_ids_of_possible_games(String.t()) :: integer()
  def sum_of_the_ids_of_possible_games(fileName) do
    max_pull = %PullResult{red: 12, green: 13, blue: 14}

    File.read!(fileName)
    |> String.split("\n")
    |> Enum.map(fn x -> Game.parse(x) end)
    |> Enum.filter(fn game ->
      Enum.all?(game.pulls, fn x -> PullResult.less_than_or_equal_to(x, max_pull) end)
    end)
    |> Enum.map(fn game -> game.id end)
    |> Enum.sum()
  end

  @doc """
  Calculate the power for each game and sum them.
  in the bad to make all the draws possible.
  """
  @spec calculate_power_of_games(String.t()) :: integer()
  def calculate_power_of_games(fileName) do
    File.read!(fileName)
    |> String.split("\n")
    |> Enum.map(fn x -> Game.parse(x) end)
    |> Enum.map(fn game -> calculate_minimum_cubes(game.pulls) end)
    |> Enum.map(fn pull -> pull.red * pull.green * pull.blue end)
    |> Enum.sum()
  end
end
