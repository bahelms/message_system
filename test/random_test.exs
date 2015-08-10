defmodule RandomTest do
  use ExUnit.Case

  test "number/0 returns a random number" do
    assert Random.number != Random.number
  end

  test "number/0 defaults to 8 digits" do
    assert Random.number |> to_char_list |> length == 8
  end

  test "number/1 sets the number of digits" do
    assert Random.number(4) |> to_char_list |> length == 4
  end
end

