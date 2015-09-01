defmodule MessageSystem.SourceTest do
  use ExUnit.Case
  alias MessageSystem.Source
  alias MessageSystem.Repo
  alias MessageSystem.POS.Arcust
  alias MessageSystem.MsgHandler

  setup do
    msg = ArcustMessage.map("1234") |> MsgHandler.sanitize
    on_exit fn -> Repo.delete_all(Arcust) end
    {:ok, msg: msg}
  end

  ## apply_change/1

  @doc "when record mode is INSERT or UPDATE"
  test "performs INSERT when no record is found", %{msg: msg} do
    Source.apply_change(msg)
    source = Arcust.query_by(%{"RCCST#" => "1234"}) |> Repo.one
    assert source."RCCST#" == "1234"
  end

  @doc "when record mode is INSERT or UPDATE"
  test "performs UPDATE when record is found", %{msg: msg} do
    %Arcust{"RCCST#": "1234"} |> Repo.insert
    Source.apply_change(msg)
    source = Arcust.query_by(%{"RCCST#" => "1234"}) |> Repo.one
    assert source."RCNAME" == "bob"
  end

  test "returns the record", %{msg: msg} do
    assert %Arcust{} == Source.apply_change(msg)
  end

  ## query_source_record/2

  test "either returns one record or nil" do
    {:ok, source} = %Arcust{"RCCST#": "1234"} |> Repo.insert
    assert Source.query_source_record(Arcust, %{"RCCST#" => "1234"}) == source
    refute Source.query_source_record(Arcust, %{"RCCST#" => "happy day"})
  end
end

