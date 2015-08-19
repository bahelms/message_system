defmodule MessageSystem.SourceTest do
  use ExUnit.Case
  import MessageSystem.Source

  @source_file "test/tmp/POS_ARCUST.csv"
  
  setup do
    File.rm(@source_file)
    {:ok, []}
  end

  test "update/1 saves the message to a file" do
    update(ArcustMessage.map("1234"))
    {:ok, record} = File.read(@source_file)
    assert record == "rccst.:1234,rcname:bob"
  end

  test "update/1 returns the message" do
    msg = ArcustMessage.map
    assert update(msg) == msg
  end
end

