defmodule MessageSystem.SourceTest do
  use ExUnit.Case
  import Ecto.Query
  alias MessageSystem.Source
  alias MessageSystem.Repo
  alias MessageSystem.POS.Arcust
  alias MessageSystem.MsgHandler

  setup do
    msg = ArcustMessage.map("1234") |> MsgHandler.sanitize
    on_exit fn -> Repo.delete_all(Arcust) end
    {:ok, msg: msg}
  end

  test "apply_change/1 saves the message to the database", %{msg: msg} do
    Source.apply_change(msg)
    query = from c in Arcust, where: c."RCCST#" == "1234"
    source = Repo.all(query) |> List.first
    assert source."RCCST#" == "1234"
  end

  test "apply_change/1 returns the record", %{msg: msg} do
    assert %Arcust{} == Source.apply_change(msg)
  end

  test "query_source_record/2 either returns one record or []" do
    {:ok, source} = %Arcust{"RCCST#": "1234"} |> Repo.insert
    result = Source.query_source_record("arcust", %{"RCCST#" => "1234"}) |> List.first
    assert result == source
  end
end

