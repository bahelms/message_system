defmodule MessageSystem.SourceTest do
  use ExUnit.Case
  alias MessageSystem.Source
  alias MessageSystem.Repo
  alias MessageSystem.POS.Arcust
  alias MessageSystem.MsgHandler

  setup do
    on_exit fn -> Repo.delete_all(Arcust) end
    {:ok, msg: sanitized_msg}
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
    Repo.insert %Arcust{"RCCST#": "1234"}
    Source.apply_change(msg)
    source = Arcust.query_by(%{"RCCST#" => "1234"}) |> Repo.one
    assert source."RCNAME" == "bob"
  end

  @doc "when record mode is INSERT or UPDATE"
  test "returns the record", %{msg: msg} do
    result = Source.apply_change(msg)
    source = Arcust.query_by(%{"RCCST#" => "1234"}) |> Repo.one
    assert result == source
  end

  @doc "when record mode is DELETE"
  test "performs DELETE when record is found" do
    Repo.insert %Arcust{"RCCST#": "1234"}
    sanitized_msg("1234", "delete") |> Source.apply_change
    assert Repo.all(Arcust) |> length == 0
  end

  @doc "when record mode is DELETE"
  test "returns the record" do
    {:ok, source} = Repo.insert %Arcust{"RCCST#": "1234"}
    result = sanitized_msg("1234", "delete") |> Source.apply_change
    assert result == source
  end

  ## query_source_record/2

  test "either returns one record or nil" do
    {:ok, source} = Repo.insert %Arcust{"RCCST#": "1234"}
    assert Source.query_source_record(Arcust, %{"RCCST#" => "1234"}) == source
    refute Source.query_source_record(Arcust, %{"RCCST#" => "happy day"})
  end

  defp sanitized_msg(number \\ "1234", mode \\ "insert") do
    ArcustMessage.map(customer_number: number, record_mode: mode)
      |> MsgHandler.sanitize
  end
end

