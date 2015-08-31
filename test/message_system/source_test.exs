defmodule MessageSystem.SourceTest do
  use ExUnit.Case
  import MessageSystem.Source
  alias MessageSystem.Repo

  test "update/1 saves the message to a file" do
    update(ArcustMessage.map("1234"))
  end

  test "update/1 returns the record" do
    msg = ArcustMessage.map
    assert update(msg) == msg
  end
end

