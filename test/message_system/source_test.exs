defmodule MessageSystem.SourceTest do
  use ExUnit.Case
  import Ecto.Query
  alias MessageSystem.Source
  alias MessageSystem.Repo
  alias MessageSystem.POS.Arcust

  setup_all do
    Repo.delete_all(Arcust)
    :ok
  end

  setup do
    on_exit fn -> Repo.delete_all(Arcust) end
    {:ok, []}
  end

  test "apply_change/1 saves the message to the database" do
    ArcustMessage.map("1234") |> Source.apply_change
    query = from c in Arcust, where: c."RCCST#" == "1234"
    assert %Arcust{"RCCST#": "1234"} == Repo.all(query)
  end

  test "apply_change/1 returns the record" do
    msg = ArcustMessage.map
    %Arcust{} = Source.apply_change(msg)
  end

  test "query_source_record/2 either returns one record or []" do
    source = %Arcust{"RCCST#" => "1234"} |> Repo.insert
    result = Source.query_source_record("arcust", %{"rccst#" => "1234"})
    assert result == source
  end
end

