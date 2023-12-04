defmodule Day03Test do
  use ExUnit.Case
  doctest Day03

  @tag :skip
  test "extract number ranges" do
    data = Day03.extract_number_ranges("467..114..", [])

    if data do
      assert data == [
               %{indices: {5, 3}, substring: "114", value: 114},
               %{indices: {0, 3}, substring: "467", value: 467}
             ]
    else
      raise "failure"
    end
  end

  @tag :skip
  test "extract symbol indices" do
    data = Day03.extract_symbol_indices("abcdABCD01234.-!@#$%^&*=/\.abcdABCD01234")

    assert data == [
             {14, "-"},
             {15, "!"},
             {16, "@"},
             {17, "#"},
             {18, "$"},
             {19, "%"},
             {20, "^"},
             {21, "&"},
             {22, "*"},
             {23, "="},
             {24, "/"}
           ]
  end

  test "sample sum number adjacent to symbols" do
    assert Day03.sum_numbers_adjacent_to_symbols("day03-sample.txt") == 4361
  end

  @tag :skip
  test "input reduced sum number adjacent to symbols" do
    # sample line 1, 139,140
    assert Day03.sum_numbers_adjacent_to_symbols("day03-input-reduced.txt") == 6891
  end

  @tag :skip
  test "input reduced sum number adjacent to symbols 02" do
    # 363+207+527+892+373+731+995++455+948+949+349+505
    # sample lines: 66-69
    # THIS IS THE EXACT OPPOSITE OF WHAT IT SHOULD BE!
    assert Day03.sum_numbers_adjacent_to_symbols("day03-input-reduced-02.txt") == 7294
  end

  @tag :skip
  test "input reduced sum number adjacent to symbols 03" do
    # 176+713+883+678+782+280+429+259+379+937+801+629+464+425+796+493+74+91+597+569+292+979+907+218+431+184+167+688
    # 176+713+883+678+782+280+429+259+379+937+801+629+464+425+796+493+74+91+597+569+292+979+907+218+431+184+167+688
    # sample lines: 4, 10, 34, 53, 122
    # 259+801+464+597+569+218 + 678+429+937+629+292+431+184+688 + 176+280+493 + 713+425+74 + 883+782+379+796+91+979+907+167
    # THIS IS THE EXACT OPPOSITE OF WHAT IT SHOULD BE!
    assert Day03.sum_numbers_adjacent_to_symbols("day03-input-reduced-03.txt") == 14321
  end

  test "input sum number adjacent to symbols" do
    # too low: 64627
    # too high: 544312
    assert Day03.sum_numbers_adjacent_to_symbols("day03-input.txt") == 539_637
  end
end
