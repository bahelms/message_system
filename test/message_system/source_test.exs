defmodule MessageSystem.SourceTest do
  use ExUnit.Case
  import MessageSystem.Source

  test "update/1 saves the message to a file" do
    update(ArcustMessage.map("1234"))
    {:ok, record} = File.read("tmp/pos_arcust.csv")
    assert record == "rccst.:1234"
  end

  test "update/1 returns the message" do
    msg = ArcustMessage.map
    assert update(msg) == msg
  end
end

